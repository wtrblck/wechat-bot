/* One request on the existing task-context checkpoint. The manager serializes
 * username/server-id into its own XML and retains no caller-owned callback.
 * ABI verified at 0x2E79C00 and 0x5BE7558 for 4.1.15.56. */
#include <stdint.h>
#include <gum/guminterceptor.h>
extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern uint32_t get_thread_id(void);
extern void *context_fn(void *);
extern void *core_fn(void *, void *);
extern void *manager_fn(void *, void *);
extern void send_fn(void *, const void *, uint64_t, uint32_t);
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
void on_checkpoint_leave(GumInvocationContext *context) {
    if (job.state != 0) return;
    void *returned = gum_invocation_context_get_return_value(context), *task = 0;
    uint32_t task_kind;
    if (!read_at(returned, &task, 8) || !read_at((unsigned char *)task + 0x388, &task_kind, 4)) return;
    int previous = 0, next = 1;
    __asm__ __volatile__("lock cmpxchgl %2, %1" : "+a" (previous), "+m" (job.state) : "r" (next) : "memory");
    if (previous != 0) return;
    job.thread_id = get_thread_id();
    void *root[2] = {0}, *core[2] = {0}, *manager[2] = {0};
    job.phase = 1; context_fn(root);
    if (!pair_valid(root)) { job.error = 1; goto cleanup; }
    job.phase = 2; core_fn(root[0], core);
    if (!pair_valid(core)) { job.error = 2; goto cleanup; }
    job.phase = 3; manager_fn(core[0], manager);
    if (!pair_valid(manager)) { job.error = 3; goto cleanup; }
    job.phase = 4;
    send_fn(manager[0], recipient_string, DOWNLOAD_SERVER_ID, 2);
    job.phase = 5;
cleanup:
    release_pair(manager); release_pair(core); release_pair(root);
    __asm__ __volatile__("" ::: "memory");
    job.state = 2;
}
