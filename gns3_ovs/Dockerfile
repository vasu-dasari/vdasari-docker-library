FROM vdasari/ovs

VOLUME /etc/openvswitch/

RUN rm /etc/openvswitch/conf.db

ADD ovs.alias /root/.bashrc

ADD boot.sh /bin/boot.sh

ADD ovs-ctl /usr/share/openvswitch/scripts

ENTRYPOINT ["/bin/boot.sh"]
