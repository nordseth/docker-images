FROM mcr.microsoft.com/dotnet/sdk:5.0

ENV HOME=/opt/app-root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/app-root/bin:/opt/app-root/.dotnet/tools \
    DOTNET_SRC_PATH=/opt/app-root/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

ENV HELM_VERSION="v3.4.2" \
    KUBE_VERSION="v1.19.6" \
    NIBBLER_VERSION="1.6.1" \
    MINVERCLI_VERSION="2.3.1" 

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm 

RUN mkdir -p ${DOTNET_SRC_PATH} && \
    useradd -u 1000 -r -g 0 -d ${HOME} -s /sbin/nologin \
      -c "Default Application User" default
RUN chown -R 1000:0 /opt/app-root 

WORKDIR ${DOTNET_SRC_PATH}

USER 1000

RUN helm repo add stable https://charts.helm.sh/stable \
    && dotnet tool install --global Nibbler --version ${NIBBLER_VERSION} \
    && dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION}
