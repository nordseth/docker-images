FROM buildpack-deps:bionic-scm

ENV HELM_VERSION="v3.9.4" \
    KUBE_VERSION="1.25.1" \
    BUILDCTL_VERSION="v0.10.4"

RUN apt-get update -q \
    && apt-get install -y software-properties-common apt-transport-https curl \
    # add kubectl
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-add-repository --yes --update "deb https://apt.kubernetes.io/ kubernetes-xenial main" \
    && apt-get install -y kubectl=$KUBE_VERSION-00 \
    # helm
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm repo add stable https://charts.helm.sh/stable \
    # buildctl
    && wget -q https://github.com/moby/buildkit/releases/download/${BUILDCTL_VERSION}/buildkit-${BUILDCTL_VERSION}.linux-amd64.tar.gz -O - | tar -xzv \
    # cleanup
    && rm -rf /var/lib/apt/lists/*
