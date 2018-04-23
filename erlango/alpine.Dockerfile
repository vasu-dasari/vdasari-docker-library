FROM erlang:20.3.2-alpine as erlang
FROM vdasari/grpc:alpine as grpc
FROM vdasari/gobgp:alpine as gobgp

COPY --from=erlang /usr/local /usr/local
COPY --from=grpc /usr/local /usr/local

RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
        dpkg-dev dpkg \
        gcc \
        g++ \
        libc-dev \
        linux-headers \
        make \
        autoconf \
        ncurses-dev \
        openssl-dev \
        unixodbc-dev \
        lksctp-tools-dev \
        tar \
        build-base \
	&& GOPATH=/usr/local/src/go \
	&& GOBGP_PATH=${GOPATH}/src/github.com/osrg/gobgp \
	&& cd ${GOBGP_PATH}/tools/grpc/cpp \
		&& ln -s ${GOBGP_PATH}/gobgp/lib/libgobgp.h \
		&& ln -s ${GOBGP_PATH}/gobgp/lib/libgobgp.so \
		&& ln -s ${GOBGP_PATH}/api/gobgp.proto gobgp_api_client.proto \
		&& make \
	&& runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u | grep -v grpc \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps

RUN set -xe \
    && apk add --no-cache --virtual .erlango-deps \
        supervisor quagga bash

ADD supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord"]
