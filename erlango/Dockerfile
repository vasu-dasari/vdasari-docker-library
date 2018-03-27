FROM erlang as erlang
FROM vdasari/grpc as grpc

FROM vdasari/gobgp:latest as gobgp

COPY --from=erlang /usr/local /usr/local
COPY --from=grpc /usr/local /usr/local

RUN apt-get update; \
    apt-get install -qy --no-install-recommends  apt-utils \
        tcpdump net-tools iputils-ping inotify-tools rsyslog ntpdate \
        curl wget build-essential bash-completion vim supervisor \
        && apt-get clean

RUN chmod +x /root/gobgp/tools/grpc/cpp/build.sh
RUN /root/gobgp/tools/grpc/cpp/build.sh

RUN touch /etc/quagga/zebra.conf
RUN touch /etc/quagga/bgpd.conf
RUN touch /etc/quagga/vtysh.conf

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Define default command.
# ENTRYPOINT ["gobgpd"]
ENTRYPOINT ["/usr/bin/supervisord"]
# ENTRYPOINT ["sleep", "infinity"]
