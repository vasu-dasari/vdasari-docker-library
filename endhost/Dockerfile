FROM debian:stable-slim

RUN set -xe \
    && buildDeps="\
        vim curl bash vlan mz net-tools tcpdump iftop\
        "\
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
    && apt-get purge -y \
    && rm -rf /var/lib/apt/lists/*
