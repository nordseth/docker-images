FROM arm64v8/debian:trixie-slim

# Raspberry Pi archive signing key (full fingerprint). The keyserver copy carries the SHA-512
# re-signatures that trixie's apt (sqv) requires; raspberrypi.gpg.key on the archive only has SHA-1 ones.
ARG RPI_ARCHIVE_FPR="CF8A1AF502A2AA2D763BAE7E82B129927FA3303E"

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates gnupg wget \
    # Raspberry Pi archive, with its key pinned via Signed-By (apt-key no longer exists in trixie)
    && wget -qO /tmp/raspberrypi.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&options=mr&search=0x${RPI_ARCHIVE_FPR}" \
    && gpg --show-keys --with-colons /tmp/raspberrypi.asc | grep -qx "fpr:::::::::${RPI_ARCHIVE_FPR}:" \
    && gpg --dearmor -o /usr/share/keyrings/raspberrypi-archive-keyring.gpg /tmp/raspberrypi.asc \
    && rm /tmp/raspberrypi.asc \
    && printf '%s\n' \
        'Types: deb' \
        'URIs: http://archive.raspberrypi.com/debian/' \
        'Suites: trixie' \
        'Components: main' \
        'Signed-By: /usr/share/keyrings/raspberrypi-archive-keyring.gpg' \
        > /etc/apt/sources.list.d/raspi.sources \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        rpicam-apps-lite ffmpeg \
        # .NET runtime dependencies, as in mcr.microsoft.com/dotnet/runtime-deps
        libc6 libgcc-s1 libicu76 libssl3t64 libstdc++6 tzdata zlib1g \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x dotnet-install.sh \
    && ./dotnet-install.sh --channel 10.0 --runtime aspnetcore --install-dir /usr/share/dotnet \
    && rm dotnet-install.sh \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && dotnet --list-runtimes

# from dotnet runtime-deps

ENV \
    # UID of the non-root user 'app'
    APP_UID=1654 \
    # Configure web servers to bind to port 8080 when present
    ASPNETCORE_HTTP_PORTS=8080 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true

RUN groupadd \
        --gid=$APP_UID \
        app \
    && useradd --no-log-init \
        --uid=$APP_UID \
        --gid=$APP_UID \
        --create-home \
        app
