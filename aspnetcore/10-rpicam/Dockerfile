FROM arm64v8/debian:bookworm-slim

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \ 
        gnupg wget ca-certificates \

    && echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E \

    && wget https://packages.microsoft.com/keys/microsoft.asc \
    && cat microsoft.asc | gpg --dearmor -o microsoft.asc.gpg \
    && mv microsoft.asc.gpg $(cat /etc/apt/sources.list.d/microsoft-prod.list | grep -oP "(?<=signed-by=).*(?=\])") \

    && wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \

    && apt-get update -y \
    && apt-get install -y --no-install-recommends \ 
        rpicam-apps-lite \
    && apt-get install -y \
        aspnetcore-runtime-10 \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

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