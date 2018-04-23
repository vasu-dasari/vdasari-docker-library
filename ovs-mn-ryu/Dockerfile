FROM vdasari/dind as dind

RUN set -xe \
        && pkgDeps='\
            openvswitch-switch openvswitch-vtep git sudo \
            arping \
            less lv netcat telnet bash-completion vim byobu \
            sudo vlan tcpdump net-tools iputils-ping bash-completion python-requests iproute2 \
            python3-pip python3-setuptools \
            python-colorama python-dev python-eventlet python-lxml python-msgpack python-netaddr python-networkx \
            python-oslo.config python-paramiko python-pip python-routes python-six python-webob \
        ' \
        && echo $pkgDeps \
        && apt-get update \
            && apt-get install -y --no-install-recommends  $pkgDeps \
        && git clone https://github.com/vasu-dasari/mininet.git /var/local/git/mininet \
            && cd /var/local/git/mininet \
            && util/install.sh -n \
        \
        && wget --no-check-certificate --quiet https://raw.githubusercontent.com/jpetazzo/pipework/master/pipework -O /usr/local/bin/pipework \
        && chmod +x /usr/local/bin/pipework \
        && pip3 install faucet \
        && rm -rf /var/local/git \
        && apt-get purge -y --auto-remove \
        && rm -rf /var/lib/apt/lists/*

# Install init
ADD ./init.dind-ovs-ryu.sh /init.dind-ovs-ryu.sh
RUN chmod +x /init.dind-ovs-ryu.sh
CMD ["wrapdocker", "/init.dind-ovs-ryu.sh"]
