FROM mcr.microsoft.com/dotnet/sdk:9.0

ENV HELM_VERSION="3.20.0" \
    KUBE_VERSION="1.35.0" \
    NIBBLER_VERSION="1.15.1" \
    MINVERCLI_VERSION="7.0.0"

RUN wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://github.com/nordseth/Nibbler/releases/download/v${NIBBLER_VERSION}/Nibbler.${NIBBLER_VERSION}_linux-x64.tar.gz -O - | tar -xzO nibbler > /usr/local/bin/nibbler \
    && chmod +x /usr/local/bin/nibbler

RUN groupadd \
        --gid=1000 \
        jenkins \
    && useradd -l \
        --uid=1000 \
        --gid=1000 \
        --create-home \
        jenkins

USER jenkins

ENV PATH=${PATH}:/home/jenkins/.dotnet/tools \
    SRC_PATH=/home/jenkins/src \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

RUN mkdir ${SRC_PATH}
WORKDIR ${SRC_PATH}

RUN dotnet tool install --global minver-cli --version ${MINVERCLI_VERSION} \
    && nibbler || true
