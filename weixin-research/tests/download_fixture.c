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
int main(int argc, char **argv) {
    printf("%llu\n", (unsigned long long)((uintptr_t)download_request-(uintptr_t)GetModuleHandleW(NULL)));
    uintptr_t base = (uintptr_t)GetModuleHandleW(NULL);
    printf("{\"send\":%llu,\"image_factory\":%llu,\"file_factory\":%llu,\"video_factory\":%llu,\"wide_assign\":%llu}\n",
        (unsigned long long)((uintptr_t)query_message-base), (unsigned long long)((uintptr_t)message_resource-base),
        (unsigned long long)((uintptr_t)resource_manager-base), (unsigned long long)((uintptr_t)start_resource_download-base),
        (unsigned long long)((uintptr_t)message_conversation-base));
    fflush(stdout);
    return active_fixture_main(argc, argv);
}
