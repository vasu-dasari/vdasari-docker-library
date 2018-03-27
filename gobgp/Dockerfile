FROM osrg/quagga

MAINTAINER Vasu Dasari <vdasari@gmail.com>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends wget lv tcpdump

ENV HOME /root
WORKDIR /root

RUN git clone https://github.com/vasu-dasari/gobgp /go/src/github.com/vasu-dasari/gobgp
RUN mkdir -p /go/src/github.com/osrg && ln -s /go/src/github.com/vasu-dasari/gobgp /go/src/github.com/osrg/gobgp
RUN go get github.com/vasu-dasari/gobgp/gobgp
RUN go get github.com/vasu-dasari/gobgp/gobgpd
RUN ln -s /go/src/github.com/vasu-dasari/gobgp .

ENTRYPOINT ["sleep", "infinity"]
