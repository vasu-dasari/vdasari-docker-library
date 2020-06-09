# FROM vdasari/kernel-ubuntu:4.9.125-0409125.201809050432 AS ksrc
# FROM linuxkit/kernel:4.9.125 AS ksrc_kit
FROM ubuntu:18.04

# COPY --from=ksrc /kernel-dev.tar /vdasari
# COPY --from=ksrc_kit /kernel-dev.tar /
# RUN tar xf kernel-dev.tar

USER root
WORKDIR /root

RUN set -xe \
        && pkgDeps='\
            automake bash-completion build-essential clang git cmake libssl-dev \
            libtool procps python python-all python-logilab-common sparse vim \
            python-setuptools bash-completion \
            curl \
            iproute2 \
            iputils-ping \
            net-tools \
            tcpdump \
            vim \
            x11-xserver-utils \
            xterm \
            jq \
            libcli1.9:amd64 \
            libjq1:amd64 \
            libnet1:amd64 \
            libonig4:amd64 \
            mz \
            tcpreplay \
            telnet \
            socat \
            iperf \
            cgroup-bin \
            kmod \
            net-tools \
            flake8 \
            netcat-openbsd \
            libelf-dev libcap-ng-dev \
            vlan' \
        && echo $pkgDeps \
        && apt-get update \
        && apt-get install -y $pkgDeps \
        && apt-get purge -y --auto-remove \
        && rm -rf /var/lib/apt/lists/*

ADD aliases.sh /root/.bash_aliases
CMD ["/bin/bash"]
