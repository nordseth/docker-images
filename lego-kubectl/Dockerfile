FROM alpine:3

ENV LEGO_VERSION="5.8.1" \
    KUBE_VERSION="1.37.3"

RUN cd /tmp \
    && wget -q https://github.com/go-acme/lego/releases/download/v${LEGO_VERSION}/lego_v${LEGO_VERSION}_linux_amd64.tar.gz \
    && wget -qO- https://github.com/go-acme/lego/releases/download/v${LEGO_VERSION}/lego_${LEGO_VERSION}_checksums.txt | grep " lego_v${LEGO_VERSION}_linux_amd64.tar.gz\$" | sha256sum -c - \
    && tar -xzOf lego_v${LEGO_VERSION}_linux_amd64.tar.gz lego > /usr/local/bin/lego \
    && rm lego_v${LEGO_VERSION}_linux_amd64.tar.gz \
    && chmod +x /usr/local/bin/lego

RUN wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && echo "$(wget -qO- https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - \
    && chmod +x /usr/local/bin/kubectl
