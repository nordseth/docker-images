FROM mcr.microsoft.com/dotnet/sdk:10.0

ENV HELM_VERSION="3.20.0" \
    KUBE_VERSION="1.35.0" \
    NIBBLER_VERSION="1.15.1"

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

RUN wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO nibbler > /usr/local/bin/nibbler \
    && chmod +x /usr/local/bin/nibbler