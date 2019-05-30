FROM alpine


RUN apk update && apk add bash openvswitch && rm -rf /var/cache/apk/*

VOLUME /etc/openvswitch/

ADD ovs.alias /root/.bashrc

ADD boot.sh /bin/boot.sh

CMD /bin/sh /bin/boot.sh
