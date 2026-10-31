/* Read-only proof that the native handler reads our private staging files.
 * ABI at 0x3A2520: rcx points to the input wstring. No file bytes or chat
 * contents are copied; only a constant label and native caller are published. */
void capture_emoji_file_read(GumInvocationContext *context) {
    const void *path = gum_invocation_context_get_nth_argument(context, 0);
    uint64_t header[4];
    const char *prefix = "E:\\projects\\wechat-bot\\weixin-research\\runs\\media-staging\\";
    uint32_t i;
    if (!read_at(path, header, 32) || header[2] < 60 || header[2] > 1024 || header[2] > header[3]) return;
    const unsigned char *data = header[3] < 8 ? path : (const void *)(uintptr_t)header[0];
    for (i=0; prefix[i]; i++) {
        uint16_t unit;
        if (!read_at(data+2*i, &unit, 2)) return;
        if (unit == '/') unit = '\\';
        if (unit != (unsigned char)prefix[i]) return;
    }
    const char *label = "native_staged_file_read";
    __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
    publish(0, (uint64_t)(uintptr_t)gum_invocation_context_get_return_address(context), 0,
        (uint64_t)(uintptr_t)label, 23, "", 0, "", 0);
}
