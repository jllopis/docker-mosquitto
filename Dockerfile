FROM debian:7.8
ENV DEBIAN_FRONTEND noninteractive

EXPOSE 1883
EXPOSE 9883

VOLUME ["/var/lib/mosquitto", "/etc/mosquitto", "/etc/mosquitto.d"]

RUN groupadd -r mosquitto && \
    useradd -r -g mosquitto mosquitto

RUN buildDeps='wget build-essential cmake bzip2 mercurial git libwrap0-dev libssl-dev libc-ares-dev xsltproc docbook docbook-xsl uuid-dev zlib1g-dev'; \
    apt-get update -q && \
    apt-get install -qy $buildDeps --no-install-recommends && \
    wget -O - http://git.warmcat.com/cgi-bin/cgit/libwebsockets/snapshot/libwebsockets-1.3-chrome37-firefox30.tar.gz | tar -zxvf - && \
    cd libwebsockets-1.3-chrome37-firefox30/ && \
    mkdir build && \
    cd build && \
    cmake .. -DOPENSSL_ROOT_DIR=/usr/bin/openssl && \
    make && \
    make install && \
    ldconfig -v && \
    cd / && rm -rf libwebsockets-1.3-chrome37-firefox30/ && \
    git clone git://git.eclipse.org/gitroot/mosquitto/org.eclipse.mosquitto.git && \
    cd org.eclipse.mosquitto && git checkout 1.4 && \
    sed -i "s/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/" config.mk && \
    make && \
    make install && \
    cd / && rm -rf org.eclipse.mosquitto && \
    mkdir /var/lib/mosquitto && \
    touch /var/lib/mosquitto/.keep && \
    chown mosquitto:mosquitto /var/lib/mosquitto && \
    apt-get purge -y --auto-remove $buildDeps

ADD mosquitto.conf /etc/mosquitto/mosquitto.conf

ENTRYPOINT ["/usr/local/sbin/mosquitto"]
CMD ["-c", "/etc/mosquitto/mosquitto.conf"]

