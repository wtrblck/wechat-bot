// Create a one-second, non-private H.264 MP4 using the Windows system encoder.
#define _WIN32_WINNT 0x0602
#include <windows.h>
#include <mfapi.h>
#include <mfidl.h>
#include <mfreadwrite.h>
#include <cstdio>

template<class T> struct Owned {
    T *p = nullptr;
    ~Owned() { if (p) p->Release(); }
    T **out() { return &p; }
    T *operator->() { return p; }
};
#define CHECK(operation) do { HRESULT hr = (operation); if (FAILED(hr)) { std::printf("failed line %d HRESULT %08lx\n", __LINE__, (unsigned long)hr); return 1; } } while (0)

int wmain(int argc, wchar_t **argv) {
    if (argc != 2) return 2;
    CHECK(CoInitializeEx(nullptr, COINIT_MULTITHREADED));
    CHECK(MFStartup(MF_VERSION));
    {
        Owned<IMFSinkWriter> sink;
        CHECK(MFCreateSinkWriterFromURL(argv[1], nullptr, nullptr, sink.out()));
        Owned<IMFMediaType> output;
        CHECK(MFCreateMediaType(output.out()));
        CHECK(output->SetGUID(MF_MT_MAJOR_TYPE, MFMediaType_Video));
        CHECK(output->SetGUID(MF_MT_SUBTYPE, MFVideoFormat_H264));
        CHECK(output->SetUINT32(MF_MT_AVG_BITRATE, 128000));
        CHECK(output->SetUINT32(MF_MT_INTERLACE_MODE, MFVideoInterlace_Progressive));
        CHECK(MFSetAttributeSize(output.p, MF_MT_FRAME_SIZE, 160, 96));
        CHECK(MFSetAttributeRatio(output.p, MF_MT_FRAME_RATE, 10, 1));
        CHECK(MFSetAttributeRatio(output.p, MF_MT_PIXEL_ASPECT_RATIO, 1, 1));
        DWORD stream;
        CHECK(sink->AddStream(output.p, &stream));
        Owned<IMFMediaType> input;
        CHECK(MFCreateMediaType(input.out()));
        CHECK(input->SetGUID(MF_MT_MAJOR_TYPE, MFMediaType_Video));
        CHECK(input->SetGUID(MF_MT_SUBTYPE, MFVideoFormat_RGB32));
        CHECK(input->SetUINT32(MF_MT_INTERLACE_MODE, MFVideoInterlace_Progressive));
        CHECK(MFSetAttributeSize(input.p, MF_MT_FRAME_SIZE, 160, 96));
        CHECK(MFSetAttributeRatio(input.p, MF_MT_FRAME_RATE, 10, 1));
        CHECK(MFSetAttributeRatio(input.p, MF_MT_PIXEL_ASPECT_RATIO, 1, 1));
        CHECK(sink->SetInputMediaType(stream, input.p, nullptr));
        CHECK(sink->BeginWriting());
        for (int n = 0; n < 10; n++) {
            Owned<IMFMediaBuffer> buffer;
            CHECK(MFCreateMemoryBuffer(160 * 96 * 4, buffer.out()));
            BYTE *bytes;
            CHECK(buffer->Lock(&bytes, nullptr, nullptr));
            for (int y = 0; y < 96; y++) for (int x = 0; x < 160; x++) {
                unsigned int i = (y * 160 + x) * 4;
                bytes[i] = 80 + n * 12; bytes[i+1] = 80 + y; bytes[i+2] = 40 + x; bytes[i+3] = 255;
            }
            CHECK(buffer->Unlock());
            CHECK(buffer->SetCurrentLength(160 * 96 * 4));
            Owned<IMFSample> sample;
            CHECK(MFCreateSample(sample.out()));
            CHECK(sample->AddBuffer(buffer.p));
            CHECK(sample->SetSampleTime(n * 1000000LL));
            CHECK(sample->SetSampleDuration(1000000));
            CHECK(sink->WriteSample(stream, sample.p));
        }
        CHECK(sink->Finalize());
    }
    CHECK(MFShutdown());
    CoUninitialize();
    std::printf("created H.264 MP4: 160x96, 10 frames, one second\n");
    return 0;
}
