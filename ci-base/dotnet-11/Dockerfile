FROM mcr.microsoft.com/dotnet/sdk:11.0

ENV HELM_VERSION="4.3.2" \
    KUBE_VERSION="1.37.2" \
    NIBBLER_VERSION="1.16.2"

ENV DOTNET_SKIP_WORKLOAD_INTEGRITY_CHECK=true
# ENV NUGET_PACKAGES=/nuget-cache

RUN wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && echo "$(wget -qO- https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O /tmp/helm.tar.gz \
    && echo "$(wget -qO- https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz.sha256)  /tmp/helm.tar.gz" | sha256sum -c - \
    && tar -xzOf /tmp/helm.tar.gz linux-amd64/helm > /usr/local/bin/helm \
    && rm /tmp/helm.tar.gz \
    && chmod +x /usr/local/bin/helm \
    # nibbler has no published checksum file, so it is not verified here
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO nibbler > /usr/local/bin/nibbler \
    && chmod +x /usr/local/bin/nibbler

# RUN dotnet new webapi -o /home/app/tmp \
#     && dotnet restore /home/app/tmp \
#     && rm -rf /home/app/tmp