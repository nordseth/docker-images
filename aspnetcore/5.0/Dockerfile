FROM mcr.microsoft.com/dotnet/aspnet:5.0

ENV HOME=/opt/app-root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/bin:/opt/app-root/.dotnet/tools \
    DOTNET_APP_PATH=/opt/app-root/app \
    ASPNETCORE_URLS=http://*:8080

RUN mkdir -p ${DOTNET_APP_PATH} && \
    useradd -u 1000 -r -g 0 -d ${HOME} -s /sbin/nologin \
      -c "Default Application User" default
RUN chown -R 1000:0 /opt/app-root 

WORKDIR ${DOTNET_APP_PATH}

USER 1000
