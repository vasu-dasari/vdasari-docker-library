FROM vdasari/grpc:latest as grpc
FROM vdasari/gobgp:latest as gobgp
FROM elixir as erlang

COPY --from=gobgp /usr/local /usr/local
COPY --from=grpc /usr/local /usr/local

RUN set -xe \
    && buildDeps="git\
        autoconf pkg-config automake libtool \
        gcc g++ make autoconf "\
        && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
    \
    && GOPATH=/usr/local/src/go \
    && GOBGP_PATH=${GOPATH}/src/github.com/osrg/gobgp \
    && cd ${GOBGP_PATH}/tools/grpc/cpp \
        && ln -s ${GOBGP_PATH}/gobgp/lib/libgobgp.h \
        && ln -s ${GOBGP_PATH}/gobgp/lib/libgobgp.so \
        && ln -s ${GOBGP_PATH}/api/gobgp.proto gobgp_api_client.proto \
        && make \
	\
    && apt-get purge -y --auto-remove $buildDeps \
	\
    && imageDeps="git\
        ca-certificates supervisor quagga bash-completion git make g++ pkg-config \
        net-tools dnsutils wget curl iputils-ping procps tcpdump locales" \
        && apt-get install -y --no-install-recommends $imageDeps \
    \
    && locale-gen en_US.UTF-8 \
    && mix local.hex --force \
    && mix local.rebar --force \
	&& ln -s /usr/local/src/go /go \
    && rm -rf /var/lib/apt/lists/*

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord"]
