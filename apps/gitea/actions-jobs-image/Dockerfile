FROM docker.io/library/alpine:latest

RUN curl -fsSL https://packages.podman.io/podman.gpg | tee /etc/apt/trusted.gpg.d/podman.asc && \
    echo "deb https://packages.podman.io/debian $(lsb_release -c | awk '{print $2}') main" | tee /etc/apt/sources.list.d/podman.list && \
    apt-get update && \
    apt-get install -y podman nodejs npm && \
    rm -rf /var/lib/apt/lists/*