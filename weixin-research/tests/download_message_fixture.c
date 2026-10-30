#define main active_fixture_main
#include "active_fixture.c"
#undef main
static unsigned int download_calls;
__declspec(dllexport) void download_request(void *manager_value, const void *username, uint64_t server_id, uint32_t reason) {
    download_calls++;
    const uint64_t *value = username;
    FILE *stream = observation ? observation : stdout;
    fprintf(stream, "{\"calls\":%u,\"server_id\":\"%llu\",\"reason\":%u,", download_calls, (unsigned long long)server_id, reason);
    print_hex(stream, "recipient", string_data((void *)username), value[2], 128);
    fprintf(stream, "\"done\":true}\n");
    fflush(stream);
}
static const void *query_recipient;
static unsigned int destroyed_optional;
static void message_destruct(void *message, uint32_t deleting) { destroyed_optional++; }
static void *message_vtable[] = {message_destruct};
__declspec(dllexport) void *query_message(void *manager_value, void *out, const void *username, uint32_t local_id, uint32_t timestamp) {
    unsigned char *bytes = out;
    if (local_id == 0) return out;
    *(void ***)bytes = message_vtable;
    *(uint32_t *)(bytes+0xc) = 3;
    *(uint32_t *)(bytes+0x144) = local_id;
    *(uint64_t *)(bytes+0x148) = 9007199254740993ULL;
    bytes[0x2e8] = 1;
    query_recipient = username;
    return out;
}
__declspec(dllexport) void *message_conversation(void *message) { return (void *)query_recipient; }
__declspec(dllexport) void *message_resource(void *out, void *message) { return fresh(out, 0x500); }
__declspec(dllexport) void *resource_manager(void *core_value, void *out) { return fresh(out, 0x500); }
__declspec(dllexport) int start_resource_download(void *manager_value, void *resource, uint32_t priority) {
    FILE *stream = observation ? observation : stdout;
    fprintf(stream, "{\"resource_download\":true,\"priority\":%u}\n", priority);
    fflush(stream);
    return 1;
}
__declspec(dllexport) void *query_unused_message(void *manager_value, Pair *out, const void *username, uint32_t local_id, uint32_t timestamp) {
    if (!local_id) return out;
    fresh(out, 0x500);
    unsigned char *bytes = out->object;
    *(void ***)bytes = message_vtable;
    *(uint32_t *)(bytes+0xc) = 3;
    *(uint32_t *)(bytes+0x144) = local_id;
    *(uint64_t *)(bytes+0x148) = 9007199254740993ULL;
    query_recipient = username;
    return out;
}
__declspec(dllexport) void *copy_owned_message(void *message, Pair *out) {
    fresh(out, 0x500); memcpy(out->object, message, 0x2e8); return out;
}
__declspec(dllexport) void *download_owned_message(void *manager_value, void *out, Pair *message, uint32_t kind, uint32_t priority) {
    Control *control = message->control;
    if (InterlockedDecrement(&control->strong) == 0) {
        destruct(control);
        if (InterlockedDecrement(&control->weak) == 0) deallocate(control);
    }
    FILE *stream = observation ? observation : stdout;
    fprintf(stream, "{\"message_download\":true,\"kind\":%u,\"priority\":%u}\n", kind, priority);
    fflush(stream);
    *(uint32_t *)out = 0x157c;
    *(uint32_t *)((char *)out+4) = 9;
    *(uint64_t *)((char *)out+32) = 15;
    return out;
}
int main(int argc, char **argv) {
    uintptr_t base = (uintptr_t)GetModuleHandleW(NULL);
    printf("{\"send\":%llu,\"image_factory\":%llu,\"wide_assign\":%llu,\"file_factory\":%llu}\n",
        (unsigned long long)((uintptr_t)query_message-base), (unsigned long long)((uintptr_t)download_owned_message-base),
        (unsigned long long)((uintptr_t)message_conversation-base), (unsigned long long)((uintptr_t)copy_owned_message-base));
    fflush(stdout);
    return active_fixture_main(argc, argv);
}
