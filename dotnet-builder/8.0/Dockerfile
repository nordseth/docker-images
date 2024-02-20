FROM mcr.microsoft.com/dotnet/sdk:8.0

ENV HELM_VERSION="3.14.1" \
    KUBE_VERSION="1.29.2" \
    NIBBLER_VERSION="1.11.0-beta.2" \
    MINVERCLI_VERSION="4.3.0"

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO Nibbler > /usr/local/bin/Nibbler

USER app

ENV PATH=${PATH}:/home/app/.dotnet/tools \
    SRC_PATH=/home/app/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

RUN mkdir ${SRC_PATH}
WORKDIR ${SRC_PATH}

RUN dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION} \
    Nibbler
