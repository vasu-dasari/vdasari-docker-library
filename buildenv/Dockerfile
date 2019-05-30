FROM debian

RUN set -xe \
		&& pkgDeps='automake bash-completion build-essential clang git cmake libssl-dev libtool procps python python-all python-logilab-common sparse vim python-setuptools' \
        && echo $pkgDeps \
        && apt-get update \
        && apt-get install -y $pkgDeps \
        && apt-get purge -y --auto-remove \
        && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
