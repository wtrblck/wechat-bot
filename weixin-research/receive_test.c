/* Bounded receive ring: guarded reads on the sync callback, policy-driven
 * filtering, and a fixed-capacity published ring instead of a one-shot record
 * area. The producer claims a monotonically increasing index, copies the record
 * into the JS-owned slot and publishes it with a trailing seq store; the consumer
 * only accepts a slot whose seq matches the index and counts reclaimed slots as
 * skips. Stack use stays small because the record itself lives in the ring.
 * Never initiates sends or changes arguments; offsets are 4.1.15.56 only. */
#include <stdint.h>
#include <gum/guminterceptor.h>

extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern volatile uint32_t counter;
/* Diagnostics, indexed by the STAT_* constants. Kept in one JS-owned block. */
extern volatile uint32_t capture_stats[];

#define STAT_ELEMENTS 0
#define STAT_UNREADABLE 1
#define STAT_OVERSIZED 2
#define STAT_FILTERED 3
#define STAT_PUBLISHED 4
#define STAT_SPAN_INVALID 5
#define STAT_CLAMPED 6
#define STAT_LAST_SPAN_LOW 8
#define STAT_LAST_SPAN_HIGH 9
#define STAT_LAST_COUNT 10
#define STAT_COUNT 12
/* Monotonic claim counter: every published value has a complete record. */
extern volatile uint32_t capture_index;
/* '\n' separated UTF-8 conversation IDs; empty prefix accepts every content. */
extern char filter_targets[];
extern char filter_prefix[];
/* 0 = content must start with the prefix, 1 = the prefix may appear anywhere. */
extern volatile uint32_t filter_mode;

#define RING_CAPACITY 64
#define CONTENT_MAX 4096
#define ID_MAX 256
#define PREFIX_MAX 64

typedef struct {
    volatile uint32_t seq; /* index + 1 once the record is complete, 0 otherwise */
    uint32_t type;
    uint64_t id;
    uint32_t timestamp, content_len, sender_len, recipient_len;
    char content[CONTENT_MAX], sender[ID_MAX], recipient[ID_MAX];
} Record;
extern Record ring[];

static int read_at(const void *source, void *destination, uint64_t size) {
    uint64_t actual = 0;
    return source != 0 && read_memory((void *)(intptr_t)-1, source, destination, size, &actual) && actual == size;
}

/* Read an MSVC string header and resolve its data pointer without copying. */
static int plain_header(uint64_t string_pointer, uint64_t *data, uint32_t *length) {
    uint64_t raw[4];
    if (!read_at((void *)(uintptr_t)string_pointer, raw, 32)) return 0;
    if (raw[2] == 0 || raw[2] > raw[3] || raw[3] > 1048576 || raw[2] > 0xFFFFFFFFu) return 0;
    *data = raw[3] < 16 ? string_pointer : raw[0];
    *length = (uint32_t)raw[2];
    return 1;
}

static int wrapper_header(uint64_t wrapper, uint64_t *data, uint32_t *length) {
    uint64_t pointer;
    if (!read_at((void *)(uintptr_t)(wrapper + 8), &pointer, 8)) return 0;
    return plain_header(pointer, data, length);
}

static void count_event(volatile uint32_t *value) {
    __asm__ __volatile__("lock incl %0" : "+m" (*value) : : "memory");
}

static void stat(unsigned int index) {
    count_event(&capture_stats[index]);
}

static int matches_target(const char *text, uint32_t size) {
    /* A lone '*' observes every conversation; the content prefix still applies. */
    if (filter_targets[0] == '*' && filter_targets[1] == 0) return 1;
    uint32_t position = 0;
    while (filter_targets[position]) {
        uint32_t start = position;
        while (filter_targets[position] && filter_targets[position] != '\n') position++;
        uint32_t length = position - start;
        if (length == size && length > 0) {
            uint32_t index = 0;
            while (index < size && filter_targets[start + index] == text[index]) index++;
            if (index == size) return 1;
        }
        if (filter_targets[position] != '\n') break;
        position++;
    }
    return 0;
}

static uint32_t prefix_length(void) {
    uint32_t length = 0;
    while (length < PREFIX_MAX && filter_prefix[length]) length++;
    return length;
}

static int has_prefix(uint64_t data, uint32_t length) {
    uint32_t needed = prefix_length();
    char buffer[PREFIX_MAX];
    if (needed == 0) return 1;
    if (length < needed) return 0;
    if (!read_at((void *)(uintptr_t)data, buffer, needed)) return 0;
    for (uint32_t i = 0; i < needed; i++) if (buffer[i] != filter_prefix[i]) return 0;
    return 1;
}

#define SEARCH_CHUNK 1024
/* Bounded substring search; group text may carry a sender prefix before the
 * marker.  Reads at most SEARCH_CHUNK + PREFIX_MAX bytes at a time so the
 * callback frame stays far below the compiler's stack-probe threshold. */
static int contains_prefix(uint64_t data, uint32_t length) {
    uint32_t needed = prefix_length();
    unsigned char buffer[SEARCH_CHUNK + PREFIX_MAX];
    if (needed == 0) return 1;
    if (length < needed) return 0;
    uint32_t position = 0;
    while (position < length) {
        uint32_t chunk = length - position;
        if (chunk > SEARCH_CHUNK) chunk = SEARCH_CHUNK;
        uint32_t span = chunk + needed - 1;
        if (span > length - position) span = length - position;
        if (!read_at((void *)(uintptr_t)(data + position), buffer, span)) return 0;
        for (uint32_t i = 0; i + needed <= span; i++) {
            uint32_t j = 0;
            while (j < needed && buffer[i + j] == filter_prefix[j]) j++;
            if (j == needed) return 1;
        }
        position += chunk;
    }
    return 0;
}

/* Claim a slot, copy the bounded record, then publish it with the trailing seq. */
static void publish(uint32_t type, uint64_t id, uint32_t timestamp,
                    uint64_t content_data, uint32_t content_length,
                    const char *sender, uint32_t sender_len,
                    const char *recipient, uint32_t recipient_len) {
    uint32_t claimed = 1;
    __asm__ __volatile__("lock xaddl %0, %1" : "+r" (claimed), "+m" (capture_index) : : "memory");
    Record *record = &ring[claimed % RING_CAPACITY];
    record->type = type;
    record->id = id;
    record->timestamp = timestamp;
    record->content_len = read_at((void *)(uintptr_t)content_data, record->content, content_length) ?
                          content_length : 0;
    record->sender_len = sender_len;
    record->recipient_len = recipient_len;
    for (uint32_t i = 0; i < sender_len; i++) record->sender[i] = sender[i];
    for (uint32_t i = 0; i < recipient_len; i++) record->recipient[i] = recipient[i];
    __asm__ __volatile__("" : : : "memory");
    record->seq = claimed + 1;
    stat(STAT_PUBLISHED);
}

void capture_enter(GumInvocationContext *context) {
    __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
    uint64_t vector[3];
    const void *argument = gum_invocation_context_get_nth_argument(context, 0);
    if (!read_at(argument, vector, sizeof(vector))) { stat(STAT_SPAN_INVALID); return; }
    if (vector[1] < vector[0] || vector[2] < vector[1]) { stat(STAT_SPAN_INVALID); return; }
    uint64_t span = vector[1] - vector[0];
    /* Last observed shape: helps distinguish layout drift from filtering. */
    capture_stats[STAT_LAST_SPAN_LOW] = (uint32_t)span;
    capture_stats[STAT_LAST_SPAN_HIGH] = (uint32_t)(span >> 32);
    if (span > 8388608 || span % 0x70 != 0) { stat(STAT_SPAN_INVALID); return; }
    uint64_t count = span / 0x70;
    capture_stats[STAT_LAST_COUNT] = (uint32_t)count;
    if (count > 32) { count = 32; stat(STAT_CLAMPED); }
    for (uint64_t i = 0; i < count; i++) {
        uint64_t message[14];
        char sender[ID_MAX], recipient[ID_MAX];
        uint64_t content_data, sender_data, recipient_data;
        uint32_t content_len, sender_len = 0, recipient_len = 0;
        stat(STAT_ELEMENTS);
        if (!read_at((void *)(uintptr_t)(vector[0] + i * 0x70), message, sizeof(message))) {
            stat(STAT_UNREADABLE);
            continue;
        }
        if (!wrapper_header(message[4], &content_data, &content_len)) { stat(STAT_UNREADABLE); continue; }
        if (content_len > CONTENT_MAX) { stat(STAT_OVERSIZED); continue; }
        if (filter_mode ? !contains_prefix(content_data, content_len) : !has_prefix(content_data, content_len)) {
            stat(STAT_FILTERED);
            continue;
        }
        if (wrapper_header(message[1], &sender_data, &sender_len) && sender_len <= ID_MAX)
            (void)read_at((void *)(uintptr_t)sender_data, sender, sender_len);
        else sender_len = 0;
        if (wrapper_header(message[3], &recipient_data, &recipient_len) && recipient_len <= ID_MAX)
            (void)read_at((void *)(uintptr_t)recipient_data, recipient, recipient_len);
        else recipient_len = 0;
        if (!matches_target(sender, sender_len) && !matches_target(recipient, recipient_len)) {
            stat(STAT_FILTERED);
            continue;
        }
        publish((uint32_t)(message[2] >> 32), message[10], (uint32_t)message[9],
                content_data, content_len, sender, sender_len, recipient, recipient_len);
    }
}
