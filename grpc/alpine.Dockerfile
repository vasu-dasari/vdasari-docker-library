FROM alpine:3.7 as builder

ENV GRPC_RELEASE_TAG v1.9.0

RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        g++ \
        make \
        autoconf \
        build-base git autoconf pkgconfig automake libtool \
    \
    && git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc \
    && cd /var/local/git/grpc \
        && git submodule update --init \
        && make && make install && make clean \
    \
    && cd /var/local/git/grpc/third_party/protobuf \
        && make && make install && make clean \
    \
    && rm -rf /var/local/git \
    \
    && scanelf --nobanner -E ET_EXEC -BF '%F' --recursive /usr/local | xargs -r strip --strip-all \
    && scanelf --nobanner -E ET_DYN -BF '%F' --recursive /usr/local | xargs -r strip --strip-unneeded \
    && runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u | grep -v grpc \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps
