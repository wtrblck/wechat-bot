/* Resident media-download worker: same verified native call sequence as
 * download_async.c, but every identifier comes from the job block so one
 * compiled module serves an unbounded number of downloads in one session.
 * Native callees own asynchronous work; no external callback is retained. */
#include <stdint.h>
#include <gum/guminterceptor.h>
extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern uint32_t get_thread_id(void);
extern void *context_fn(void *);
extern void *core_fn(void *, void *);
extern void *manager_fn(void *, void *);
extern void *send_fn(void *, void *, const void *, uint32_t, uint32_t);
extern void *image_factory_fn(void *, void *, void *, uint32_t, uint32_t, const void *);
extern void *future_pair[2];
extern void string_destroy_fn(void *);
extern void *file_factory_fn(void *, void *);
extern void *wide_assign_fn(void *);
extern void release_pair(void **);
extern unsigned char recipient_string[];
typedef struct {
    volatile int state;
    uint32_t phase, error, kind, thread_id, reserved[3];
    unsigned char result[128];
    uint32_t detail_len;
    char detail[512];
    uint32_t local_id, create_time, message_type, media_kind;
    uint64_t server_id;
} Job;
extern Job job;
static int read_at(const void *p, void *out, uint64_t size) {
    uint64_t n = 0;
    return p && read_memory((void *)(intptr_t)-1, p, out, size, &n) && n == size;
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
static int same_string(const unsigned char *left, const unsigned char *right) {
    uint64_t a[4], b[4];
    if (!read_at(left, a, 32) || !read_at(right, b, 32) || a[2] != b[2] || a[2] > 128 || a[3] < a[2] || b[3] < b[2]) return 0;
    const unsigned char *ap = a[3] < 16 ? left : (const unsigned char *)(uintptr_t)a[0];
    const unsigned char *bp = b[3] < 16 ? right : (const unsigned char *)(uintptr_t)b[0];
    unsigned char ac[128], bc[128];
    if (!read_at(ap, ac, a[2]) || !read_at(bp, bc, b[2])) return 0;
    for (uint64_t i = 0; i < a[2]; i++) if (ac[i] != bc[i]) return 0;
    return 1;
}
void on_checkpoint_leave(GumInvocationContext *context) {
    if (job.state != 0) return;
    void *returned = gum_invocation_context_get_return_value(context), *task = 0;
    uint32_t task_kind;
    if (!read_at(returned, &task, 8) || !read_at((unsigned char *)task + 0x388, &task_kind, 4)) return;
    int previous = 0, next = 1;
    __asm__ __volatile__("lock cmpxchgl %2, %1" : "+a" (previous), "+m" (job.state) : "r" (next) : "memory");
    if (previous != 0) return;
    job.thread_id = get_thread_id();
    void *root[2] = {0}, *core[2] = {0}, *manager[2] = {0}, *resource[2] = {0};
    uint64_t aligned_message[94] = {0};
    unsigned char *message = (unsigned char *)aligned_message;
    job.phase = 1; context_fn(root);
    if (!pair_valid(root)) { job.error = 1; goto cleanup; }
    job.phase = 2; core_fn(root[0], core);
    if (!pair_valid(core)) { job.error = 2; goto cleanup; }
    job.phase = 3; manager_fn(core[0], manager);
    if (!pair_valid(manager)) { job.error = 3; goto cleanup; }
    job.phase = 4;
    send_fn(manager[0], message, recipient_string, job.local_id, job.create_time);
    if (!message[0x2e8]) { job.error = 4; goto cleanup; }
    uint32_t local_id, type;
    uint64_t server_id;
    if (!read_at(message + 0x144, &local_id, 4) || !read_at(message + 0xc, &type, 4) ||
        !read_at(message + 0x148, &server_id, 8) || local_id != job.local_id ||
        server_id != job.server_id || type != job.message_type ||
        !same_string(wide_assign_fn(message), recipient_string)) { job.error = 5; goto cleanup; }
    job.phase = 5;
    file_factory_fn(message, resource);
    if (!pair_valid(resource)) { job.error = 6; goto cleanup; }
    void *transferred[2] = {resource[0], resource[1]};
    resource[0] = 0; resource[1] = 0;
    job.phase = 6;
    /* Native options: flags=1 and two empty std::wstring values. The native
     * task constructor copies these; no probe-owned data is retained. */
    uint64_t options[9] = {0};
    options[0] = 1; options[4] = 7; options[8] = 7;
    image_factory_fn(manager[0], future_pair, transferred, job.media_kind, 0, options);
    /* Never call the synchronous wrapper or wait/get on this checkpoint. */
    if (!pair_valid(future_pair)) job.error = 7;
    job.phase = 7;
cleanup:
    release_pair(resource);
    if (message[0x2e8]) {
        void **vtable = *(void ***)message;
        ((void (*)(void *, uint32_t))vtable[0])(message, 0);
    }
    release_pair(manager); release_pair(core); release_pair(root);
    __asm__ __volatile__("" ::: "memory");
    job.state = 2;
}

/* Only the host calls this after the checkpoint has returned. */
int close_download(void) {
    if (job.state != 2 && job.state != 3) return 0;
    release_pair(future_pair);
    future_pair[0] = 0; future_pair[1] = 0;
    return 1;
}
