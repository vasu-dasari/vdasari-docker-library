FROM erlang:17
MAINTAINER vdasari@gmail.com

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    build-essential libpcap-dev vim tcpdump net-tools iputils-ping uml-utilities

# Install Docker from Docker Inc. repositories.
RUN git clone https://github.com/FlowForwarding/LINC-Switch.git

ADD ./sys.config.orig /LINC-Switch/rel/files/sys.config.orig

RUN cd LINC-Switch && \
      cp rel/files/sys.config.orig rel/files/sys.config && \
      make

WORKDIR /LINC-Switch
