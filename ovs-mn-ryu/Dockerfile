FROM vdasari/dind as dind

# Install OVS
RUN apt-get update && apt-get install -y openvswitch-switch openvswitch-vtep git sudo

# Install mininet
# RUN git clone git://github.com/mininet/mininet && \
RUN git clone https://github.com/vasu-dasari/mininet.git && \
	cd mininet && \
	util/install.sh -n

# Install Python packages
RUN bash -c 'apt-get install -y python-{colorama,dev,eventlet,lxml,msgpack,netaddr,networkx,oslo.config,paramiko,pip,routes,six,webob}'

# Install pipework
RUN apt-get install -y arping
RUN wget --no-check-certificate --quiet https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework -O /usr/local/bin/pipework
RUN chmod +x /usr/local/bin/pipework

# Install misc useful stuffs
RUN apt-get install -y less lv netcat telnet bash-completion vim byobu

RUN apt-get install -y sudo vlan tcpdump net-tools iputils-ping bash-completion python-requests iproute2

# Install Ryu and faucet
# RUN pip install ryu
RUN apt-get install -y python3-pip
RUN pip3 install faucet

# Install init
ADD ./init.dind-ovs-ryu.sh /init.dind-ovs-ryu.sh
RUN chmod +x /init.dind-ovs-ryu.sh
CMD ["wrapdocker", "/init.dind-ovs-ryu.sh"]
