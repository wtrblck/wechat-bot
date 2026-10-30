/* Synchronous shared_ptr release matching this binary's observed control block. */
#include <stdint.h>
static int last_reference(volatile int *value) {
    int previous = -1;
    __asm__ __volatile__("lock xaddl %0, %1" : "+r" (previous), "+m" (*value) : : "memory");
    return previous == 1;
}
void release_pair(void **pair) {
    unsigned char *control = pair[1];
    pair[0] = pair[1] = 0;
    if (control && last_reference((volatile int *)(control + 8))) {
        void **vtable = *(void ***)control;
        ((void (*)(void *))vtable[0])(control);
        if (last_reference((volatile int *)(control + 12)))
            ((void (*)(void *))vtable[1])(control);
    }
}
