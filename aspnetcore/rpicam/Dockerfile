FROM mcr.microsoft.com/dotnet/aspnet:9.0-bookworm-slim-arm64v8

RUN apt-get update \
    && apt-get install -y --no-install-recommends gnupg \
    && echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        rpicam-apps-lite \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*