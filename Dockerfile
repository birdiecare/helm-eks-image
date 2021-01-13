FROM ubuntu:20.04

#Known working - v2.0.59
#Latest - v2.1.14
ARG AWSCLI_VERSION="2.0.59"

#Known working - v1.19.3
#Latest - v1.20.1
ARG KUBECTL_VERSION="1.19.3"

#Known working - v3.4.2
#Latest - v3.4.2
ARG HELM_VERSION="3.4.2"

#Known working - v3.6.1
#Latest - v3.6.1
ARG SOPS_VERSION="3.6.1"

RUN apt update -y -qq && \
    apt-get install -yqq curl unzip wget ca-certificates tar git make

RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-$AWSCLI_VERSION.zip" -o "awscliv2.zip" && \
    unzip -qq awscliv2.zip && \
    ./aws/install

RUN curl -LOs "https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
     chmod +x ./kubectl && \
     mv ./kubectl /usr/local/bin/kubectl

RUN wget "https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz" -q && \
    tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm

RUN curl -sL "https://github.com/mozilla/sops/releases/download/v$SOPS_VERSION/sops-v$SOPS_VERSION.linux" > sops && \
    chmod +x sops && \
    mv sops /usr/local/bin/sops

RUN helm plugin install https://github.com/jkroepke/helm-secrets --version v3.4.0 && \
    wget https://github.com/lrills/helm-unittest/releases/download/v0.1.5/helm-unittest-linux-0.1.5.tgz && \
    mkdir -p ${HOME}/.local/share/helm/plugins/unittest && \
    tar xzf helm-unittest-linux-0.1.5.tgz -C ${HOME}/.local/share/helm/plugins/unittest

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
