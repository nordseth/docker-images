FROM arm64v8/ubuntu:noble AS builder

RUN apt update && \
    apt install -y git build-essential && \
    apt install -y cmake libboost-program-options-dev libdrm-dev libexif-dev && \
    apt install -y ffmpeg libavcodec-extra libavcodec-dev libavdevice-dev libpng-dev libpng-tools libepoxy-dev

RUN git clone https://github.com/raspberrypi/rpicam-apps.git
RUN cd rpicam-apps/
RUN meson setup build -Denable_libav=false -Denable_drm=true -Denable_egl=false -Denable_qt=false -Denable_opencv=false -Denable_tflite=false
RUN meson compile -C build
RUN meson install -C build
RUN ldconfig
RUN rpicam-still --version
RUN echo "test" > /test.txt

FROM mcr.microsoft.com/dotnet/aspnet:10.0-noble-arm64v8

COPY --from=builder /test.txt .