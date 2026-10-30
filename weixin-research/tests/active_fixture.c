#include <windows.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

typedef struct { void **vtable; volatile LONG strong, weak; void *object; } Control;
typedef struct { void *object; Control *control; } Pair;
static volatile LONG live_controls, context_calls, send_calls, freed_result_strings,
    freed_voice_payloads, freed_narrow_strings;
/* Large observations go to a file: the parent is blocked in the synchronous
 * dispatch call and cannot drain a full stdout pipe while the job runs. */
static FILE *observation;
static void free_string(unsigned char *field) {
    if (*(uint64_t *)(field + 24) >= 16) HeapFree(GetProcessHeap(), 0, *(void **)field);
}
static void destruct(Control *control) {
    unsigned char *object = control->object;
    uint32_t type = *(uint32_t *)(object + 0x118);
    /* Context/core/manager fixtures are only 0x500 bytes; +0x758 exists only on
     * message objects. Keep the reads inside the real allocation size. */
    int message = type == 1 || type == 3 || type == 43 || type == 34 || type == 49;
    if (*(uint64_t *)(object + 0xb0 + 24) >= 16) {
        free_string(object + 0xb0);
        InterlockedIncrement(&freed_narrow_strings);
    }
    if (message) {
        if (*(uint64_t *)(object + 0x120 + 24) >= 8)
            HeapFree(GetProcessHeap(), 0, *(void **)(object + 0x120));
        if (type == 34 && *(uint64_t *)(object + 0x758 + 24) >= 16) {
            free_string(object + 0x758);
            InterlockedIncrement(&freed_voice_payloads);
        } else if (type != 34 && *(uint64_t *)(object + 0x758 + 24) >= 16) {
            free_string(object + 0x758);
            InterlockedIncrement(&freed_narrow_strings);
        }
    }
    HeapFree(GetProcessHeap(), 0, object);
}
static void deallocate(Control *control) { InterlockedDecrement(&live_controls); HeapFree(GetProcessHeap(), 0, control); }
static void *vtable[] = {destruct, deallocate};
static Pair *fresh(Pair *out, size_t size) {
    Control *control = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, sizeof(Control));
    control->vtable = vtable; control->strong = control->weak = 1;
    control->object = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, size);
    out->object = control->object; out->control = control;
    InterlockedIncrement(&live_controls);
    return out;
}
static const char *string_data(void *string) {
    uint64_t *raw = string;
    return raw[3] < 16 ? string : (void *)(uintptr_t)raw[0];
}
__declspec(dllexport) Pair *context(Pair *out) { InterlockedIncrement(&context_calls); return fresh(out, 0x500); }
__declspec(dllexport) Pair *core(void *unused, Pair *out) { return fresh(out, 0x500); }
__declspec(dllexport) Pair *manager(void *unused, Pair *out) { return fresh(out, 0x500); }
__declspec(dllexport) __attribute__((noinline)) Pair *checkpoint(void) {
    static unsigned char task[0x500];
    static Pair pair;
    pair.object = task;
    *(uint32_t *)(task + 0x388) = 3;
    return &pair;
}
__declspec(dllexport) Pair *text_factory(Pair *out) {
    fresh(out, 0x798);
    *(uint64_t *)((char *)out->object + 0xb0 + 24) = 15;
    *(uint64_t *)((char *)out->object + 0x758 + 24) = 15;
    return out;
}
__declspec(dllexport) Pair *media_factory(Pair *out) {
    fresh(out, 0x798);
    *(uint64_t *)((char *)out->object + 0xb0 + 24) = 15;
    *(uint64_t *)((char *)out->object + 0x120 + 24) = 7;
    return out;
}
/* Mirrors the real factory: copy the recipient string into the message instead of
 * aliasing the caller's descriptor. */
static void copy_string(unsigned char *field, void *source) {
    uint64_t *header = source;
    const char *data = string_data(source);
    if (header[2] < 16) {
        memcpy(field, data, header[2]);
        field[header[2]] = 0;
        *(uint64_t *)(field + 24) = 15;
    } else {
        char *copy = HeapAlloc(GetProcessHeap(), 0, header[2] + 1);
        memcpy(copy, data, header[2] + 1);
        *(void **)field = copy;
        *(uint64_t *)(field + 24) = header[2];
    }
    *(uint64_t *)(field + 16) = header[2];
}
__declspec(dllexport) Pair *voice_factory(Pair *out, void *recipient, uint64_t *payload, uint32_t *duration, unsigned char *metadata) {
    fresh(out, 0x7b8);
    unsigned char *object = out->object;
    copy_string(object + 0xb0, recipient);
    char *copied = HeapAlloc(GetProcessHeap(), 0, payload[2] + 1);
    memcpy(copied, string_data(payload), payload[2] + 1);
    uint64_t *target = (uint64_t *)(object + 0x758);
    target[0] = (uintptr_t)copied; target[2] = target[3] = payload[2];
    *(uint32_t *)(object + 0x778) = *duration;
    memcpy(object + 0x780, metadata, 17);
    memcpy(object + 0x798, metadata + 24, 32);
    return out;
}
__declspec(dllexport) void *wide_assign(uint64_t *out, uint64_t *input) {
    wchar_t *source = input[3] < 8 ? (wchar_t *)input : (wchar_t *)(uintptr_t)input[0];
    wchar_t *data = HeapAlloc(GetProcessHeap(), 0, (input[2] + 1) * 2);
    memcpy(data, source, (input[2] + 1) * 2);
    out[0] = (uintptr_t)data; out[2] = input[2]; out[3] = input[2];
    return out;
}
/* Mirrors 0x1F9AD0: replace the destination with a copy of the source string.
 * Inline below 16 bytes, otherwise a fresh fixture allocation owned by the object. */
__declspec(dllexport) void *narrow_assign(uint64_t *out, uint64_t *input) {
    const char *source = string_data(input);
    uint64_t length = input[2];
    if (length < 16) {
        if (out[3] >= 16) HeapFree(GetProcessHeap(), 0, (void *)(uintptr_t)out[0]);
        memcpy(out, source, length);
        ((char *)out)[length] = 0;
        out[2] = length;
        out[3] = 15;
        return out;
    }
    char *data = HeapAlloc(GetProcessHeap(), 0, length + 1);
    memcpy(data, source, length + 1);
    if (out[3] >= 16) HeapFree(GetProcessHeap(), 0, (void *)(uintptr_t)out[0]);
    out[0] = (uintptr_t)data;
    out[2] = length;
    out[3] = length;
    return out;
}
__declspec(dllexport) void string_destroy(uint64_t *value) {
    if (value[3] >= 16) {
        HeapFree(GetProcessHeap(), 0, (void *)(uintptr_t)value[0]);
        InterlockedIncrement(&freed_result_strings);
    }
}
static void print_hex(FILE *stream, const char *label, const void *data, uint64_t size, uint64_t maximum) {
    fprintf(stream, "\"%s_hex\":\"", label);
    const unsigned char *bytes = data;
    if (size <= maximum) for (uint64_t i = 0; i < size; i++) fprintf(stream, "%02x", bytes[i]);
    fprintf(stream, "\",\"%s_len\":%llu,", label, (unsigned long long)size);
}
__declspec(dllexport) void *send_message(void *unused, unsigned int *out, Pair *message) {
    char *object = message->object;
    uint32_t type = *(uint32_t *)(object + 0x118);
    const char *recipient = string_data(object + 0xb0);
    const char *body = string_data(object + 0x758);
    int valid = recipient[0] != 0;
    const char *kind = type == 3 ? "image" : type == 49 ? "file" : type == 43 ? "video" : type == 34 ? "voice" : "text";
    if (type == 1) valid = valid && body[0] != 0;
    else if (type == 34) {
        const unsigned char expected[] = {2, '#', '!', 'S', 'I', 'L', 'K', '_', 'V', '3'};
        valid = valid && *(uint64_t *)(object + 0x758 + 16) > 16 &&
            memcmp(body, expected, sizeof(expected)) == 0 &&
            *(uint32_t *)(object + 0x778) == 1000 && *(uint32_t *)(object + 0x780) == 4 &&
            *(uint32_t *)(object + 0x784) == 3 && *(uint64_t *)(object + 0x788) == 30000 &&
            *(uint64_t *)(object + 0x7b0) == 15;
    }
    else valid = valid && wcsstr(*(wchar_t **)(object + 0x120), L"wxbot-") != NULL;
    if (type == 49) valid = valid && *(uint32_t *)(object + 0x11c) == 6;
    out[0] = valid ? 0 : 17; out[1] = 0;
    const char *diagnostic = "wxbot fixture owned result diagnostic";
    uint64_t *result_string = (uint64_t *)((char *)out + 8);
    size_t length = strlen(diagnostic);
    char *copy = HeapAlloc(GetProcessHeap(), 0, length + 1);
    memcpy(copy, diagnostic, length + 1);
    result_string[0] = (uintptr_t)copy; result_string[2] = result_string[3] = length;
    fresh((Pair *)((char *)out + 0x28), 0x500);
    InterlockedIncrement(&send_calls);
    FILE *stream = observation ? observation : stdout;
    fprintf(stream, "{\"called\":\"%s\",\"valid\":%s,", kind, valid ? "true" : "false");
    print_hex(stream, "recipient", recipient, strlen(recipient), 512);
    if (type == 1) print_hex(stream, "body", body, *(uint64_t *)(object + 0x758 + 16), 8192);
    else if (type == 34) print_hex(stream, "body", body, *(uint64_t *)(object + 0x758 + 16), 0);
    fprintf(stream, "\"done\":true}\n");
    fflush(stream);
    if (InterlockedDecrement(&message->control->strong) == 0) {
        destruct(message->control);
        if (InterlockedDecrement(&message->control->weak) == 0) deallocate(message->control);
    }
    return out;
}
int main(int argc, char **argv) {
    if (argc > 1) {
        observation = fopen(argv[1], "w");
        if (observation) setvbuf(observation, NULL, _IONBF, 0);
    }
    uintptr_t base = (uintptr_t)GetModuleHandleW(NULL);
    printf("{\"context\":%llu,\"core\":%llu,\"manager\":%llu,\"text_factory\":%llu,\"send\":%llu,\"image\":%llu,\"thread_checkpoint\":%llu,\"image_factory\":%llu,\"file_factory\":%llu,\"wide_assign\":%llu,\"video_factory\":%llu,\"string_destroy\":%llu,\"voice_factory\":%llu,\"narrow_assign\":%llu}\n",
        (unsigned long long)((uintptr_t)context-base), (unsigned long long)((uintptr_t)core-base),
        (unsigned long long)((uintptr_t)manager-base), (unsigned long long)((uintptr_t)text_factory-base),
        (unsigned long long)((uintptr_t)send_message-base),
        (unsigned long long)((uintptr_t)media_factory-base),
        (unsigned long long)((uintptr_t)checkpoint-base),
        (unsigned long long)((uintptr_t)media_factory-base), (unsigned long long)((uintptr_t)media_factory-base),
        (unsigned long long)((uintptr_t)wide_assign-base), (unsigned long long)((uintptr_t)media_factory-base),
        (unsigned long long)((uintptr_t)string_destroy-base), (unsigned long long)((uintptr_t)voice_factory-base),
        (unsigned long long)((uintptr_t)narrow_assign-base));
    fflush(stdout);
    int reported = 0;
    for (int i = 0; i < 600; i++) {
        checkpoint();
        if (!reported && context_calls && live_controls == 0) {
            printf("{\"cleanup\":true,\"send_calls\":%ld,\"freed_result_strings\":%ld,\"freed_voice_payloads\":%ld,\"freed_narrow_strings\":%ld}\n",
                   send_calls, freed_result_strings, freed_voice_payloads, freed_narrow_strings);
            fflush(stdout); reported = 1;
        }
        Sleep(50);
    }
    return 0;
}
