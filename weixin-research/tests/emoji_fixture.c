#define main active_fixture_main
#include "active_fixture.c"
#undef main
static int corrupt_copy, result_error, import_error;
static volatile LONG emoji_frees, delayed_reads, local_imports;
__declspec(dllexport) unsigned char emoji_import(void *unused, void **pair) {
    if(import_error) return 0;
    unsigned char *input=pair[0];
    if (!input || *(uint64_t *)(input+16)!=32 ||
        memcmp(string_data(input),"abcdef0123456789abcdef0123456789",32) ||
        *(uint64_t *)(input+80)<8 || *(uint64_t *)(input+88)<8) return 0;
    const wchar_t *path=*(const wchar_t **)(input+64);
    if(wcscmp(path,L"E:/fixtures/local-animation.gif")) return 0;
    InterlockedIncrement(&local_imports);
    return 1;
}
static Pair pending_emoji;
static void release_emoji_resource(Pair *pair);
static void emoji_message_destruct(Control *control) {
    unsigned char *object=control->object;
    Pair *resource=(Pair *)(object+0x758);
    if(*(uint32_t *)(object+0x118)==47 && resource->control) {
        release_emoji_resource(resource);memset(resource,0,sizeof(Pair));
    }
    if (*(uint64_t *)(object+0x138)>=8)
        HeapFree(GetProcessHeap(),0,*(void **)(object+0x120));
    destruct(control);
}
static void *emoji_message_vtable[]={emoji_message_destruct,deallocate};
static void emoji_destruct(void *control) {
    unsigned char *object=(unsigned char *)control+16;
    for(int offset=0x10;offset<=0x170;offset+=0x20) free_string(object+offset);
    free_string(object+0x1a0);
    InterlockedIncrement(&emoji_frees);
}
static void emoji_deallocate(void *control) {
    HeapFree(GetProcessHeap(),0,control);InterlockedDecrement(&live_controls);
}
__declspec(dllexport) void *emoji_vtable[]={emoji_destruct,emoji_deallocate};
__declspec(dllexport) void *local_control_vtable[]={emoji_destruct,emoji_deallocate};
static uint32_t base_length(void *object) { return 0; }
static uint32_t local_length(void *object) { return *(uint32_t *)((unsigned char *)object+0x1c8); }
static void *base_resource_vtable[]={0,0,0,0,0,0,base_length};
__declspec(dllexport) void *local_resource_vtable[]={0,0,0,0,0,0,local_length};
__declspec(dllexport) void *emoji_new(size_t size) {
    if(size!=0x1f0 && size!=0x1e0) ExitProcess(90);
    InterlockedIncrement(&live_controls);
    return HeapAlloc(GetProcessHeap(),HEAP_ZERO_MEMORY,size);
}
__declspec(dllexport) void *emoji_construct(unsigned char *out,unsigned char *record) {
    static int sources[]={0,0x128,0x20,0x40,0x60,0x80,0xa0,0xc0,0xe0,0x100,0x148,0x168};
    memset(out,0,0x1e0);
    *(void **)out=base_resource_vtable;
    *(uint32_t *)(out+8)=*(uint32_t *)(record+0x120);
    for(int i=0;i<12;i++) copy_string(out+0x10+i*32,record+sources[i]);
    copy_string(out+0x1a0,record+0x188);
    if(corrupt_copy) ((char *)string_data(out+0x10))[0]='X';
    return out;
}
__declspec(dllexport) void *emoji_local_copy(unsigned char *out,unsigned char *source) {
    if(*(void **)source!=base_resource_vtable) ExitProcess(91);
    memset(out,0,0x1d0);
    *(void **)out=local_resource_vtable;
    *(uint32_t *)(out+8)=*(uint32_t *)(source+8);
    for(int offset=0x10;offset<=0x170;offset+=0x20) copy_string(out+offset,source+offset);
    copy_string(out+0x1a0,source+0x1a0);
    uint32_t (*getter)(void *)=((void **)*(void **)source)[6];
    *(uint32_t *)(out+0x1c8)=getter(source);
    return out;
}
__declspec(dllexport) Pair *emoji_factory(Pair *out) {
    fresh(out,0x790);
    out->control->vtable=emoji_message_vtable;
    *(uint64_t *)((char *)out->object+0xb0+24)=15;
    *(uint64_t *)((char *)out->object+0x120+24)=7;
    return out;
}
static void release_emoji_resource(Pair *pair) {
    LONG *counts=(LONG *)((char *)pair->control+8);
    if(InterlockedDecrement(counts)==0) {
        emoji_destruct(pair->control);
        if(InterlockedDecrement(counts+1)==0) emoji_deallocate(pair->control);
    }
}
static DWORD WINAPI read_later(void *unused) {
    Sleep(350); /* after probe script unload, with only native-owned bytes */
    unsigned char *message=pending_emoji.object;
    Pair *resource=(Pair *)(message+0x758);
    unsigned char *object=resource->object;
    int valid=*(uint32_t *)(message+0x118)==47 && object==(unsigned char *)resource->control+16 &&
        *(uint64_t *)(object+0x20)==32 &&
        memcmp(string_data(object+0x10),"abcdef0123456789abcdef0123456789",32)==0 &&
        (*(uint32_t *)(object+8)==4 ? local_imports && *(uint64_t *)(object+0x80)==0 &&
          *(uint64_t *)(message+0x130)==wcslen(L"E:/fixtures/local-animation.gif") &&
          wcscmp(*(wchar_t **)(message+0x120),L"E:/fixtures/local-animation.gif")==0 &&
          *(void **)object==local_resource_vtable && local_length(object)==123456 :
         *(uint64_t *)(message+0x130)==0 && *(uint64_t *)(object+0x80)==32 && memcmp(string_data(object+0x70),"0123456789abcdef0123456789abcdef",32)==0);
    FILE *stream=observation?observation:stdout;
    fprintf(stream,"{\"valid\":%s,\"type\":47,\"native_owned_after_unload\":true,",valid?"true":"false");
    print_hex(stream,"recipient",string_data(message+0xb0),*(uint64_t *)(message+0xc0),128);
    fprintf(stream,"\"done\":true}\n");fflush(stream);
    emoji_message_destruct(pending_emoji.control);deallocate(pending_emoji.control);
    InterlockedIncrement(&delayed_reads);
    return 0;
}
__declspec(dllexport) void *emoji_send(void *manager_value,unsigned char *out,Pair *message) {
    InterlockedIncrement(&send_calls);pending_emoji=*message;
    *(uint32_t *)out=result_error?0x157c:0;*(uint32_t *)(out+4)=result_error?3:0;
    *(uint64_t *)(out+32)=15;
    HANDLE thread=CreateThread(NULL,0,read_later,NULL,0,NULL);CloseHandle(thread);
    return out;
}
int main(int argc,char **argv) {
    corrupt_copy=argc>2?atoi(argv[2]):0;result_error=argc>3?atoi(argv[3]):0;
    import_error=argc>4?atoi(argv[4]):0;
    uintptr_t base=(uintptr_t)GetModuleHandleW(NULL);
    printf("{\"text_factory\":%llu,\"send\":%llu,\"emoji_construct\":%llu,\"emoji_new\":%llu,\"emoji_control_vtable\":%llu,\"emoji_import\":%llu,\"emoji_local_copy\":%llu,\"local_control_vtable\":%llu,\"local_resource_vtable\":%llu}\n",
        (unsigned long long)((uintptr_t)emoji_factory-base),(unsigned long long)((uintptr_t)emoji_send-base),
        (unsigned long long)((uintptr_t)emoji_construct-base),(unsigned long long)((uintptr_t)emoji_new-base),
        (unsigned long long)((uintptr_t)emoji_vtable-base),
        (unsigned long long)((uintptr_t)emoji_import-base),
        (unsigned long long)((uintptr_t)emoji_local_copy-base),
        (unsigned long long)((uintptr_t)local_control_vtable-base),
        (unsigned long long)((uintptr_t)local_resource_vtable-base));fflush(stdout);
    return active_fixture_main(argc,argv);
}
