FROM mcr.microsoft.com/dotnet/core/sdk:3.1

RUN mkdir /app
WORKDIR /app

ENV HELM_VERSION="v3.3.4" \
    KUBE_VERSION="v1.19.2" \
    NIBBLER_VERSION="1.4.0" \
    MINVERCLI_VERSION="2.3.0" \
    PATH="${PATH}:/root/.dotnet/tools"

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm repo add stable https://kubernetes-charts.storage.googleapis.com/ \
    && dotnet tool install --global Nibbler --version ${NIBBLER_VERSION} \
    && dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION}
