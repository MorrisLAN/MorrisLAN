FROM docker.io/library/node:16-bullseye

RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common && \
    curl -fsSL https://packages.podman.io/podman.gpg | tee /etc/apt/trusted.gpg.d/podman.asc && \
    echo "deb https://packages.podman.io/debian $(lsb_release -c | awk '{print $2}') main" | tee /etc/apt/sources.list.d/podman.list && \
    apt-get update && \
    apt-get install -y podman && \
    rm -rf /var/lib/apt/lists/*