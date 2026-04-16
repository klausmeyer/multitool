FROM debian:trixie-20260406

ARG SOURCE_VERSION
ENV SOURCE_VERSION=$SOURCE_VERSION

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT=$SOURCE_COMMIT

ENV K8S_VERSION="1.35.4"
ENV K8S_PACKAGE_VERSION="${K8S_VERSION}-1.1"
ENV K8S_REPO_VERSION="v1.35"

# renovate: repo=https://packages.buildkite.com/helm-linux/helm-debian/any/ suite=any components=main depName=helm
ENV HELM_VERSION="3.20.0-1"

ENV YQ_VERSION="4.52.4"

RUN apt-get update && \
  apt-get install -y apt-transport-https ca-certificates curl figlet git gnupg jq && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -fsSL "https://pkgs.k8s.io/core:/stable:/${K8S_REPO_VERSION}/deb/Release.key" | \
  gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
  chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_REPO_VERSION}/deb/ /" > \
  /etc/apt/sources.list.d/kubernetes.list && \
  apt-get update && \
  apt-get install -y "kubectl=${K8S_PACKAGE_VERSION}"

# helm
RUN curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor -o /usr/share/keyrings/helm.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | \
  tee /etc/apt/sources.list.d/helm-stable-debian.list && \
  apt-get update && \
  apt-get install "helm=${HELM_VERSION}"

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
  chmod 644 /etc/apt/keyrings/docker.asc && \
  echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian trixie stable" | \
  tee /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get install -y docker-ce-cli docker-compose-plugin

# yq
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_$(test "$(uname -m)" = "aarch64" && echo "arm64" || echo "amd64")" \
  -o /usr/local/bin/yq && \
  chmod +x /usr/local/bin/yq

ADD info.sh /root

CMD ["/root/info.sh"]
