FROM buildpack-deps:noble-scm

ENV HELM_VERSION="4.3.2" \
    KUBE_VERSION="1.37.3" \
    BUILDCTL_VERSION="0.35.1"

RUN \
    # add kubectl
    wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && echo "$(wget -qO- https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - \
    && chmod +x /usr/local/bin/kubectl \
    # helm
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O /tmp/helm.tar.gz \
    && echo "$(wget -qO- https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz.sha256)  /tmp/helm.tar.gz" | sha256sum -c - \
    && tar -xzOf /tmp/helm.tar.gz linux-amd64/helm > /usr/local/bin/helm \
    && rm /tmp/helm.tar.gz \
    && chmod +x /usr/local/bin/helm \
    # buildctl has no published checksum file (only a sigstore bundle), so it is not verified here
    # buildctl
    # (extract only buildctl; unpacking the tarball's bin/ at / would replace the /bin -> usr/bin symlink)
    && wget -q https://github.com/moby/buildkit/releases/download/v${BUILDCTL_VERSION}/buildkit-v${BUILDCTL_VERSION}.linux-amd64.tar.gz -O - | tar -xzO bin/buildctl > /usr/local/bin/buildctl \
    && chmod +x /usr/local/bin/buildctl
