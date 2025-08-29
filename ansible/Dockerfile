FROM buildpack-deps:noble-scm

ENV HELM_VERSION="3.18.6" \
    KUBE_VERSION="1.34.0"

RUN apt-get update -q \
    && apt-get install -y software-properties-common apt-transport-https curl \
    # add ansible
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible \
    # add kubectl
    && wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    # add iso/cloud image utils
    && apt-get install -y --no-install-recommends genisoimage cloud-image-utils \
    # helm
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    # cleanup
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.ssh \
    && chmod 700 /root/.ssh

RUN mkdir /ansible
WORKDIR /ansible

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD [ "/bin/bash", "-i"]
