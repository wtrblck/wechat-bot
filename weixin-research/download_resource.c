/* Obtain an owned native database message, resolve its owned media resource,
 * and submit it to WeChat's resource manager. No external callback is retained. */
#include <stdint.h>
#include <gum/guminterceptor.h>
extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern uint32_t get_thread_id(void);
extern void *context_fn(void *);
extern void *core_fn(void *, void *);
extern void *manager_fn(void *, void *);
extern void *send_fn(void *, void *, const void *, uint32_t, uint32_t);
extern void *image_factory_fn(void *, void *);
extern void *file_factory_fn(void *, void *);
extern int video_factory_fn(void *, void *, uint32_t);
extern void *wide_assign_fn(void *);
extern void release_pair(void **);
extern unsigned char recipient_string[];
typedef struct {
    volatile int state;
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
    void *root[2] = {0}, *core[2] = {0}, *manager[2] = {0}, *resource[2] = {0}, *downloads[2] = {0};
    uint64_t aligned_message[94] = {0}; /* optional<0x2e8-byte message>, aligned */
    unsigned char *message = (unsigned char *)aligned_message;
    job.phase = 1; context_fn(root);
    if (!pair_valid(root)) { job.error = 1; goto cleanup; }
    job.phase = 2; core_fn(root[0], core);
    if (!pair_valid(core)) { job.error = 2; goto cleanup; }
    job.phase = 3; manager_fn(core[0], manager);
    if (!pair_valid(manager)) { job.error = 3; goto cleanup; }
    job.phase = 4;
    send_fn(manager[0], message, recipient_string, DOWNLOAD_LOCAL_ID, DOWNLOAD_CREATE_TIME);
    if (!message[0x2e8]) { job.error = 4; goto cleanup; }
    uint32_t local_id, type;
    uint64_t server_id;
    if (!read_at(message + 0x144, &local_id, 4) || !read_at(message + 0xc, &type, 4) ||
        !read_at(message + 0x148, &server_id, 8) || local_id != DOWNLOAD_LOCAL_ID ||
        server_id != DOWNLOAD_SERVER_ID || type != DOWNLOAD_MESSAGE_TYPE ||
        !same_string(wide_assign_fn(message), recipient_string)) { job.error = 5; goto cleanup; }
    job.phase = 5;
    image_factory_fn(resource, message);
    if (!pair_valid(resource)) { job.error = 6; goto cleanup; }
    if (!DOWNLOAD_EXECUTE) goto cleanup;
    job.phase = 6;
    file_factory_fn(core[0], downloads);
    if (!pair_valid(downloads)) { job.error = 7; goto cleanup; }
    job.phase = 7;
    job.reserved[0] = video_factory_fn(downloads[0], resource, 500);
    if (!job.reserved[0]) job.error = 8;
cleanup:
    release_pair(downloads); release_pair(resource);
    if (message[0x2e8]) {
        void **vtable = *(void ***)message;
        ((void (*)(void *, uint32_t))vtable[0])(message, 0);
    }
    release_pair(manager); release_pair(core); release_pair(root);
    __asm__ __volatile__("" ::: "memory");
    job.state = 2;
}
