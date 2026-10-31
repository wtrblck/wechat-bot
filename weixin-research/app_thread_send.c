/* One synchronous job after a native task-context checkpoint has returned.
 * No JS runs on a WeChat business thread. Never interrupts an arbitrary thread.
 * Every string given to WeChat is copied by WeChat's own std::string assignment,
 * so no probe buffer is retained by the asynchronous message. */
#include <stdint.h>
#include <gum/guminterceptor.h>
extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern uint32_t get_thread_id(void);
extern void *context_fn(void *);
extern void *core_fn(void *, void *);
extern void *manager_fn(void *, void *);
extern void *factory_fn(void *);
extern void *send_fn(void *, void *, void *);
extern void *image_fn(void *, void *, void *, void *);
extern void *image_factory_fn(void *);
extern void *file_factory_fn(void *);
extern void *video_factory_fn(void *);
extern void *voice_factory_fn(void *, void *, void *, void *, void *);
extern void *wide_assign_fn(void *, void *);
extern void *narrow_assign_fn(void *, void *);
extern void string_destroy_fn(void *);
extern void release_pair(void **);
extern unsigned char text_string[], recipient_string[], wide_path[], voice_string[];
extern uint32_t voice_duration;
#ifdef ENABLE_EMOJI
extern unsigned char emoji_record[], emoji_control_vtable[];
extern void *emoji_new_fn(uint64_t);
extern void *emoji_construct_fn(void *, const void *);
extern void *emoji_factory_fn(void *);
#ifdef ENABLE_LOCAL_EMOJI
/* RVA 0x6978540: synchronous cache import. rcx is unused; rdx points to a
 * borrowed pair whose object holds MD5 +0 and std::wstring path +0x40.
 * No input pointer escapes this call (local-emoticon-import*.asm). */
extern unsigned char emoji_import_fn(void *, void **);
extern void *local_emoji_input[];
extern void *emoji_local_copy_fn(void *, const void *);
extern unsigned char local_emoji_control_vtable[], local_emoji_resource_vtable[];
extern uint32_t local_emoji_size;
#endif
#endif
typedef struct {
    volatile int state; /* 0 armed, 1 executing, 2 finished, 3 cancelled */
    uint32_t phase, error, kind, thread_id, reserved[3];
    unsigned char result[128];
    uint32_t detail_len;
    char detail[512];
} Job;
extern Job job;
static int read_at(const void *p, void *out, uint64_t size) {
    uint64_t n = 0;
    return p && read_memory((void *)(intptr_t)-1, p, out, size, &n) && n == size;
}
static int claim(void) {
    int previous = 0, next = 1;
    __asm__ __volatile__("lock cmpxchgl %2, %1" : "+a" (previous), "+m" (job.state) : "r" (next) : "memory");
    return previous == 0;
}
int cancel_job(void) {
    int previous = 0, next = 3;
    __asm__ __volatile__("lock cmpxchgl %2, %1" : "+a" (previous), "+m" (job.state) : "r" (next) : "memory");
    return previous;
}
static int pair_valid(void **pair) {
    uintptr_t scratch;
    return read_at(pair[0], &scratch, 8) && read_at(pair[1], &scratch, 8);
}
/* Byte-wise comparison that never dereferences a guessed pointer. */
static int same_bytes(const unsigned char *left, const unsigned char *right, uint64_t size) {
    unsigned char a[96], b[96];
    for (uint64_t offset = 0; offset < size; offset += sizeof(a)) {
        uint64_t chunk = size - offset < sizeof(a) ? size - offset : sizeof(a);
        if (!read_at(left + offset, a, chunk) || !read_at(right + offset, b, chunk)) return 0;
        for (uint64_t i = 0; i < chunk; i++) if (a[i] != b[i]) return 0;
    }
    return 1;
}
/* MSVC std::string: size at +0x10, capacity at +0x18, inline storage below 16. */
static const unsigned char *string_data(const unsigned char *field, uint64_t header[4]) {
    return header[3] < 16 ? field : (const unsigned char *)(uintptr_t)header[0];
}
/* Confirm the destination holds exactly the probe's UTF-8 bytes and terminator. */
static int verify_narrow(const unsigned char *field, const unsigned char *source) {
    uint64_t current[4], wanted[4];
    unsigned char terminator = 1;
    if (!read_at(field, current, 32) || !read_at(source, wanted, 32)) return 0;
    if (current[2] != wanted[2] || current[3] < current[2] || current[3] < 15) return 0;
    if (wanted[2] > wanted[3]) return 0;
    const unsigned char *data = string_data(field, current);
    const unsigned char *origin = string_data(source, wanted);
    if (!read_at(data + current[2], &terminator, 1) || terminator != 0) return 0;
    return same_bytes(data, origin, current[2]);
}
/* Copy through WeChat's own assignment so the message owns WeChat-allocated bytes. */
static int assign_narrow(const unsigned char *field, const unsigned char *source) {
    uint64_t current[4], wanted[4];
    if (!read_at(field, current, 32) || !read_at(source, wanted, 32)) return 0;
    if (current[3] < 15 || current[2] > current[3]) return 0;
    if (wanted[2] > wanted[3]) return 0;
    narrow_assign_fn((void *)field, (void *)source);
    return verify_narrow(field, source);
}
void on_checkpoint_leave(GumInvocationContext *context) {
    if (job.state != 0) return;
    void *returned = gum_invocation_context_get_return_value(context), *task = 0;
    uint32_t task_kind;
    if (!read_at(returned, &task, 8) ||
        !read_at((unsigned char *)task + 0x388, &task_kind, 4) || !claim()) return;
    job.thread_id = get_thread_id();
    void *root[2] = {0}, *core[2] = {0}, *manager[2] = {0}, *message[2] = {0};
#ifdef ENABLE_EMOJI
    void *emoji_resource[2] = {0};
    void *local_resource[2] = {0};
#endif
    job.phase = 1; context_fn(root);
    if (!pair_valid(root)) { job.error = 1; goto cleanup; }
    job.phase = 2; core_fn(root[0], core);
    if (!pair_valid(core)) { job.error = 2; goto cleanup; }
    job.phase = 3; manager_fn(core[0], manager);
    if (!pair_valid(manager)) { job.error = 3; goto cleanup; }
    if (job.kind == 0) goto cleanup;
    job.phase = 4;
    if (job.kind == 5) {
        /* Metadata copied exactly from 0x5E09640 -> 0x6CD0550: format 4,
         * codec 3, option 30000, flag 0, empty trailing MSVC string. */
        unsigned char metadata[56] = {0};
        *(uint32_t *)metadata = 4;
        *(uint32_t *)(metadata + 4) = 3;
        *(uint64_t *)(metadata + 8) = 30000;
        *(uint64_t *)(metadata + 48) = 15;
        voice_factory_fn(message, recipient_string, voice_string, &voice_duration, metadata);
    }
    else if (job.kind == 2) image_factory_fn(message);
    else if (job.kind == 3) file_factory_fn(message);
    else if (job.kind == 4) video_factory_fn(message);
#ifdef ENABLE_EMOJI
    else if (job.kind == 6) emoji_factory_fn(message);
#endif
    else factory_fn(message);
    if (!pair_valid(message)) { job.error = 4; goto cleanup; }
    /* The voice factory copies the recipient itself; the other factories build an
     * empty string that is replaced here through WeChat's assignment routine. */
    if (job.kind != 5 && !assign_narrow((unsigned char *)message[0] + 0xb0, recipient_string)) {
        job.error = 5; goto cleanup;
    }
    if (job.kind == 5) {
        uint64_t raw[4];
        uint32_t duration;
        if (!read_at((unsigned char *)message[0] + 0x758, raw, 32) ||
            raw[2] != *(uint64_t *)(voice_string + 16) ||
            !read_at((unsigned char *)message[0] + 0x778, &duration, 4) || duration != voice_duration) {
            job.error = 7; goto cleanup;
        }
        *(uint32_t *)((unsigned char *)message[0] + 0x118) = 34;
    }
    else if (job.kind == 6) {
#ifdef ENABLE_EMOJI
#ifdef ENABLE_LOCAL_EMOJI
        if (job.reserved[0] && !emoji_import_fn(0, local_emoji_input)) {
            job.error = 14; goto cleanup;
        }
#else
        if (job.reserved[0]) { job.error = 14; goto cleanup; }
#endif
        /* Exact native make_shared layout from 0x6977344 -> 0x20A2800:
         * 0x1f0 allocation, native control vtable, strong/weak = 1, object +16.
         * The native constructor copies every borrowed database string. */
        unsigned char *control = emoji_new_fn(0x1f0);
        if (!control) { job.error = 10; goto cleanup; }
        *(void **)control = emoji_control_vtable;
        *(uint32_t *)(control + 8) = 1; *(uint32_t *)(control + 12) = 1;
        emoji_construct_fn(control + 16, emoji_record);
        emoji_resource[0] = control + 16; emoji_resource[1] = control;
        if (!verify_narrow(control + 16 + 0x10, emoji_record) ||
            !verify_narrow(control + 16 + 0x30, emoji_record + 0x128) ||
            !verify_narrow(control + 16 + 0x50, emoji_record + 0x20) ||
            !verify_narrow(control + 16 + 0x70, emoji_record + 0x40)) {
            job.error = 11; goto cleanup;
        }
#ifdef ENABLE_LOCAL_EMOJI
        if (job.reserved[0]) {
            /* EmoticonMessageHandler vtable +0x78 -> 0x5AF3320:
             * when the upload buffer at message+0x768 is empty, +0x130
             * (wstring length) gates the local file read at 0x5AF373A.
             * Importing the display cache alone leaves this path empty and
             * cannot upload an unknown hash. Copy the staged path into the
             * message with the same native owned-string ABI as image sends. */
            uint64_t path_header[4], source_path[4];
            unsigned char *path_field = (unsigned char *)message[0] + 0x120;
            if (!read_at(path_field, path_header, 32) || path_header[2] || path_header[3] != 7 ||
                !read_at(wide_path, source_path, 32) || !source_path[2]) {
                job.error = 17; goto cleanup;
            }
            wide_assign_fn(path_field, wide_path);
            if (!read_at(path_field, path_header, 32) || path_header[2] != source_path[2]) {
                job.error = 17; goto cleanup;
            }
            /* 0x487BBE6 and 0x22FD932 allocate 0x1e0. 0x22FC160 is a
             * COPY constructor: its source must be a fully constructed native
             * resource (including its virtual size getter), never a record or
             * local-path buffer. The prior experiment violated that ABI.
             * Keep its native resource ownership and length alongside the
             * message's actual local upload path. */
            if (!local_emoji_size) { job.error = 15; goto cleanup; }
            unsigned char *owned = emoji_new_fn(0x1e0);
            if (!owned) { job.error = 10; goto cleanup; }
            *(void **)owned = local_emoji_control_vtable;
            *(uint32_t *)(owned + 8) = 1; *(uint32_t *)(owned + 12) = 1;
            emoji_local_copy_fn(owned + 16, emoji_resource[0]);
            local_resource[0] = owned + 16; local_resource[1] = owned;
            if (*(void **)(owned + 16) != local_emoji_resource_vtable ||
                !verify_narrow(owned + 16 + 0x10, emoji_record)) {
                job.error = 16; goto cleanup;
            }
            /* Native subtype's +0x30 virtual getter reads DWORD +0x1c8;
             * its debug serializer identifies this as "length". */
            *(uint32_t *)(owned + 16 + 0x1c8) = local_emoji_size;
            release_pair(emoji_resource);
            emoji_resource[0] = local_resource[0]; emoji_resource[1] = local_resource[1];
            local_resource[0] = local_resource[1] = 0;
        }
#endif
        void **target = (void **)((unsigned char *)message[0] + 0x758);
        if (target[0] || target[1]) { job.error = 12; goto cleanup; }
        target[0] = emoji_resource[0]; target[1] = emoji_resource[1];
        emoji_resource[0] = emoji_resource[1] = 0;
        *(uint32_t *)((unsigned char *)message[0] + 0x118) = 47;
#ifdef EMOJI_BUILD_ONLY
        job.phase = 6; goto cleanup;
#endif
#else
        job.error = 13; goto cleanup;
#endif
    }
    else if (job.kind == 1) {
        if (!assign_narrow((unsigned char *)message[0] + 0x758, text_string)) {
            job.error = 8; goto cleanup;
        }
        *(uint32_t *)((unsigned char *)message[0] + 0x118) = 1;
    } else {
        uint64_t raw[4];
        unsigned char *path_field = (unsigned char *)message[0] + 0x120;
        if (!read_at(path_field, raw, 32) || raw[2] != 0 || raw[3] != 7) {
            job.error = 6; goto cleanup;
        }
        wide_assign_fn(path_field, wide_path);
        *(uint64_t *)((unsigned char *)message[0] + 0x118) = job.kind == 2 ? 3 : job.kind == 4 ? 43 : 0x600000031ULL;
    }
    void *transferred[2] = {message[0], message[1]};
    message[0] = message[1] = 0;
    job.phase = 5; send_fn(manager[0], job.result, transferred);
    /* Result ABI: status[2], std::string at +8, owned shared_ptr at +0x28.
     * Copy only bounded diagnostics, then release the result just like callers. */
    uint64_t result_string[4];
    if (read_at(job.result + 8, result_string, 32) && result_string[2] <= 512 &&
        result_string[2] <= result_string[3]) {
        const void *data = result_string[3] < 16 ? job.result + 8 : (void *)(uintptr_t)result_string[0];
        if (read_at(data, job.detail, result_string[2])) job.detail_len = result_string[2];
    }
    string_destroy_fn(job.result + 8);
    release_pair((void **)(job.result + 0x28));
cleanup:
#ifdef ENABLE_EMOJI
    release_pair(local_resource);
    release_pair(emoji_resource);
#endif
    release_pair(message); release_pair(manager); release_pair(core); release_pair(root);
    __asm__ __volatile__("" : : : "memory");
    job.state = 2;
}
