FROM mcr.microsoft.com/dotnet/sdk:6.0-bookworm-slim

ENV HOME=/opt/app-root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/bin:/opt/app-root/.dotnet/tools \
    DOTNET_SRC_PATH=/opt/app-root/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

ENV HELM_VERSION="3.16.2" \
    KUBE_VERSION="1.31.1" \
    NIBBLER_VERSION="1.11.0" \
    MINVERCLI_VERSION="5.0.0"

RUN wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO nibbler > /usr/local/bin/nibbler \
    && chmod +x /usr/local/bin/nibbler

RUN mkdir -p ${DOTNET_SRC_PATH} && \
    useradd -u 1000 -r -g 0 -d ${HOME} -s /sbin/nologin \
      -c "Default Application User" default
RUN chown -R 1000:0 /opt/app-root 

WORKDIR ${DOTNET_SRC_PATH}

USER 1000

RUN dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION} \
    && nibbler || true
