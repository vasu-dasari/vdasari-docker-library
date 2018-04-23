FROM debian:stretch

ENV GRPC_RELEASE_TAG v1.9.0

RUN set -xe \
    && buildDeps="gcc\
        g++ \
        make \
        ca-certificates \
        autoconf pax-utils \
        build-essential git autoconf pkg-config automake libtool" \
        && apt-get update \
        && apt-get install -y --no-install-recommends $buildDeps \
    \
    && git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc.git /var/local/git/grpc \
    && cd /var/local/git/grpc \
        && git submodule update --init \
        && make && make install && make clean \
    \
    && cd /var/local/git/grpc/third_party/protobuf \
        && make && make install && make clean \
	\
    && scanelf --nobanner -E ET_EXEC -BF '%F' --recursive /usr/local | xargs -r strip --strip-all \
    && scanelf --nobanner -E ET_DYN -BF '%F' --recursive /usr/local | xargs -r strip --strip-unneeded \
    \
    && rm -rf /var/local/git \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf $ERL_TOP /var/lib/apt/lists/*
