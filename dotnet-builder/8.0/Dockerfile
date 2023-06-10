FROM mcr.microsoft.com/dotnet/sdk:8.0-preview

ENV HELM_VERSION="3.12.0" \
    KUBE_VERSION="1.27.2" \
    NIBBLER_VERSION="1.9.0" \
    MINVERCLI_VERSION="4.3.0"

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm 

USER app

ENV PATH=${PATH}:/home/app/.dotnet/tools \
    SRC_PATH=/home/app/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

RUN mkdir ${SRC_PATH}
WORKDIR ${SRC_PATH}

RUN helm repo add stable https://charts.helm.sh/stable \
    && dotnet tool install --global Nibbler --version ${NIBBLER_VERSION} \
    && dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION}