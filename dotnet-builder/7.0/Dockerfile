FROM mcr.microsoft.com/dotnet/sdk:7.0

ENV HOME=/opt/app-root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/bin:/opt/app-root/.dotnet/tools \
    DOTNET_SRC_PATH=/opt/app-root/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

ENV HELM_VERSION="3.14.1" \
    KUBE_VERSION="1.29.2" \
    NIBBLER_VERSION="1.11.0-beta.3" \
    MINVERCLI_VERSION="4.3.0"

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO nibbler > /usr/local/bin/nibbler \
    && chmod +x /usr/local/bin/nibbler

RUN groupadd --system --gid 1000 app && \
    adduser --uid 1000 -gid 1000 --shell /bin/false --home ${HOME} --system app && \
    mkdir ${DOTNET_SRC_PATH} && \
    chown 1000:1000 ${DOTNET_SRC_PATH}

WORKDIR ${DOTNET_SRC_PATH}

USER 1000

RUN dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION} \
    && nibbler || true
