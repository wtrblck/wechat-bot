/* Read an existing send-stage invocation; never initiates or replays a send.
 * Uses the same observation policy and ring as the receive capture. */
void capture_send_enter(GumInvocationContext *context) {
    __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
    uint64_t stage, message, content_data, recipient_data;
    const void *pair = gum_invocation_context_get_nth_argument(context, 2);
    if (!read_at(pair, &stage, 8) ||
        !read_at((void *)(uintptr_t)(stage + 0x08), &message, 8)) return;
    uint32_t content_len, recipient_len, type;
    char recipient[ID_MAX];
    if (!plain_header(message + 0x758, &content_data, &content_len)) { stat(STAT_UNREADABLE); return; }
    if (content_len > CONTENT_MAX) { stat(STAT_OVERSIZED); return; }
    if (filter_mode ? !contains_prefix(content_data, content_len) : !has_prefix(content_data, content_len)) {
        stat(STAT_FILTERED);
        return;
    }
    if (!plain_header(message + 0xb0, &recipient_data, &recipient_len) || recipient_len > ID_MAX ||
        !read_at((void *)(uintptr_t)recipient_data, recipient, recipient_len) ||
        !matches_target(recipient, recipient_len)) {
        stat(STAT_FILTERED);
        return;
    }
    if (!read_at((void *)(uintptr_t)(message + 0x118), &type, 4)) return;
    publish(type, 0, 0, content_data, content_len, "", 0, recipient, recipient_len);
}
