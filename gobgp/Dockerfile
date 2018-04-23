# Stage 0
FROM golang:1.9.4-stretch as builder

MAINTAINER Vasu Dasari <vdasari@gmail.com>

ENV VERSION_TAG v1.29

USER root
WORKDIR /root
RUN set -xe \
    && cd / && GOPATH=/usr/local/src/go && mkdir -p /usr/local/src \
        && mv /go /usr/local/src && ln -s ${GOPATH} /go && cd /go \
    && buildDeps="gcc \
        git \
        linux-headers \
        musl-dev" \
    && go get -u github.com/golang/dep/cmd/dep \
    && go get -d github.com/osrg/gobgp \
    # HACK: "go get" will return 1 due to no Go files in "github.com/osrg/gobgp",
    # here uses "||" to avoid failure of building Docker image.
    || cd ${GOPATH}/src/github.com/osrg/gobgp && git checkout ${VERSION_TAG} \
    && dep ensure -v \
    && go install ./gobgp \
    && go install ./gobgpd \
    && cd gobgp/lib \
    && go build -buildmode=c-shared -o libgobgp.so *.go \
    && rm -rf ${GOPATH}/pkg

# Stage 1
FROM debian:stretch
USER root
WORKDIR /root
COPY --from=builder /usr/local/src /usr/local/src
COPY --from=builder /go/bin/gobgp  /usr/local/bin/.
COPY --from=builder /go/bin/gobgpd /usr/local/bin/.
