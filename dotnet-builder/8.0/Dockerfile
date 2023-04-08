FROM mcr.microsoft.com/dotnet/sdk:8.0-preview

RUN echo $HOME
RUN echo $PATH

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

ENV HELM_VERSION="3.11.2" \
    KUBE_VERSION="1.26.3" \
    NIBBLER_VERSION="1.8.2" \
    MINVERCLI_VERSION="4.3.0"

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm repo add stable https://charts.helm.sh/stable \
    && dotnet tool install --global Nibbler --version ${NIBBLER_VERSION} \
    && dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION}
