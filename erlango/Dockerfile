FROM erlang as erlang
FROM vdasari/grpc as grpc

FROM osrg/gobgp as gobgp

COPY --from=erlang /usr/local /usr/local
COPY --from=grpc /usr/local /usr/local

RUN apt-get update; \
    apt-get install -y apt-utils \
        tcpdump net-tools iputils-ping inotify-tools rsyslog ntpdate \
        curl wget build-essential bash-completion vim \
        && apt-get clean

RUN chmod +x "$GOPATH"/src/github.com/osrg/gobgp/tools/grpc/cpp/build.sh
RUN "$GOPATH"/src/github.com/osrg/gobgp/tools/grpc/cpp/build.sh

# Define default command.
ENTRYPOINT ["gobgpd"]
# ENTRYPOINT ["sleep", "infinity"]
