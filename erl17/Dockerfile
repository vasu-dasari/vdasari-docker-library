FROM erlang:17.5

RUN set -xe \
        dpkg --print-architecture && \
        curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture)" \
        && chmod +x /usr/local/bin/gosu

ENV TZ=US/Eastern
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

CMD ["/bin/bash"]
