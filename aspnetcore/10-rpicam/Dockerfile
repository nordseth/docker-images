FROM arm64v8/debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \ 
        gnupg wget ca-certificates \

    && echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E \

    && apt-get update -y \
    && apt-get install -y --no-install-recommends \ 
        rpicam-apps-lite \
    # Install dependencies for dotnet runtime
    && apt-get install -y \
        libc6 libgcc-s1 libgssapi-krb5-2 libicu72 libssl3 libstdc++6 zlib1g \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x dotnet-install.sh \
    && ./dotnet-install.sh --channel 10.0 --runtime aspnetcore --install-dir /usr/share/dotnet \
    && rm dotnet-install.sh \
    && ls -l /usr/share/dotnet \
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