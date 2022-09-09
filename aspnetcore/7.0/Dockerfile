FROM mcr.microsoft.com/dotnet/aspnet:7.0

ENV HOME=/opt/app-root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/bin:/opt/app-root/.dotnet/tools \
    DOTNET_APP_PATH=/opt/app-root/app \
    ASPNETCORE_URLS=http://*:8080

RUN mkdir -p ${DOTNET_APP_PATH} && \
    groupadd --system --gid 101 app && \
    adduser --uid 101 -gid 101 --shell /bin/false --home ${HOME} --system app && \
    chown -R 101:101 /opt/app-root 

WORKDIR ${DOTNET_APP_PATH}

USER 101