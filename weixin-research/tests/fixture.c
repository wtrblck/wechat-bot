#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static volatile unsigned long counter = 0;
__declspec(dllexport) __attribute__((noinline)) void observed(void *vector, void *unused, void *message_pair) {
    counter++;
}

int main(int argc, char **argv) {
    const char *text = argc > 2 && strcmp(argv[2], "nonmarker") == 0 ? "ordinary-fixture-text" : "wxbot-fixture-1028";
    if (argc > 2 && strcmp(argv[2], "group") == 0) text = "wxid_fixture_sender:\nwxbot-fixture-1028";
    uint64_t content_string[4] = {(uintptr_t)text, 0, strlen(text), 63};
    uint64_t helper_string[4] = {0, 0, 10, 15};
    memcpy(helper_string, "filehelper", 10);
    if (argc > 2 && strcmp(argv[2], "nonhelper") == 0) memcpy(helper_string, "other-user", 10);
    uint64_t content_wrapper[3] = {0, (uintptr_t)content_string, 1};
    uint64_t helper_wrapper[3] = {0, (uintptr_t)helper_string, 1};
    uint64_t message[14] = {0};
    message[1] = (uintptr_t)helper_wrapper;
    message[2] = ((uint64_t)1 << 32) | 123;
    message[3] = (uintptr_t)helper_wrapper;
    message[4] = (uintptr_t)content_wrapper;
    message[9] = 1793180000;
    message[10] = 123456789012345ULL;
    uint64_t vector[3] = {(uintptr_t)message, (uintptr_t)message + sizeof(message),
                          (uintptr_t)message + sizeof(message)};
    if (argc > 2 && strcmp(argv[2], "invalidpointer") == 0) message[4] = 1;
    unsigned char native_message[0x798] = {0};
    memcpy(native_message + 0xb0, helper_string, 32);
    memcpy(native_message + 0x758, content_string, 32);
    *(uint32_t *)(native_message + 0x118) = 1;
    uint64_t stage_context[32] = {0};
    stage_context[1] = (uintptr_t)native_message;
    uint64_t message_pair[2] = {(uintptr_t)stage_context, 0};
    uintptr_t base = (uintptr_t)GetModuleHandleW(NULL);
    printf("%llu %llu\n", (unsigned long long)((uintptr_t)&observed - base),
           (unsigned long long)base);
    fflush(stdout);
    int burst = argc > 2 && strcmp(argv[2], "burst") == 0;
    // Give the host time to attach and install the hook before the burst, so a
    // zero-catch run can only mean a probe defect, not a race with startup.
    if (burst) Sleep(1200);
    unsigned long limit = argc > 1 ? strtoul(argv[1], NULL, 10) : 2000;
    for (unsigned long i = 0; i < limit; i++) {
        // Burst mode produces a distinct message id per call and never sleeps, so
        // the ring must absorb or count the overflow instead of losing it silently.
        if (burst) message[10] = 123456789012345ULL + i;
        observed(vector, NULL, message_pair);
        if (!burst) Sleep(10);
    }
    if (burst) for (;;) Sleep(100);
    return 0;
}
