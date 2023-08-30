FROM alpine:3

ENV LEGO_VERSION="4.14.0" \
    KUBE_VERSION="1.28.1"

RUN wget -q https://github.com/go-acme/lego/releases/download/v${LEGO_VERSION}/lego_v${LEGO_VERSION}_linux_amd64.tar.gz -O - | tar -xzO lego > /usr/local/bin/lego \
    && chmod +x /usr/local/bin/lego 

RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl 
