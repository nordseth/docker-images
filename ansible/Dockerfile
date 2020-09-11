FROM buildpack-deps:bionic-scm

ENV HELM_VERSION="v3.3.1" \
    KUBE_VERSION="1.19.1"

RUN apt-get update -q \
    && apt-get install -y software-properties-common apt-transport-https curl \
    # add ansible
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible \
    # add kubectl
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-add-repository --yes --update "deb https://apt.kubernetes.io/ kubernetes-xenial main" \
    && apt-get install -y kubectl=$KUBE_VERSION-00 \
    # add iso/cloud image utils
    && apt-get install -y --no-install-recommends genisoimage cloud-image-utils \
    # helm
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm repo add stable https://kubernetes-charts.storage.googleapis.com/ \
    # cleanup
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/.ssh \
    && chmod 700 /root/.ssh

RUN mkdir /ansible
WORKDIR /ansible

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD [ "/bin/bash", "-i"]
