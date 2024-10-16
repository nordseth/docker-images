FROM buildpack-deps:jammy-scm

ENV HELM_VERSION="3.16.2" \
    KUBE_VERSION="1.31.1" \
    BUILDCTL_VERSION="0.16.0"

RUN \
    # add kubectl
    wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    # helm
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    # buildctl
    && wget -q https://github.com/moby/buildkit/releases/download/v${BUILDCTL_VERSION}/buildkit-v${BUILDCTL_VERSION}.linux-amd64.tar.gz -O - | tar -xzv \
    # cleanup
    && rm -rf /var/lib/apt/lists/*
