FROM debian:8.1
ENV DEBIAN_FRONTEND noninteractive

EXPOSE 1883
EXPOSE 9883

VOLUME ["/var/lib/mosquitto", "/etc/mosquitto", "/etc/mosquitto.d"]

RUN groupadd -r mosquitto && \
    useradd -r -g mosquitto mosquitto

RUN buildDeps='wget build-essential cmake bzip2 mercurial git libwrap0-dev libssl-dev libc-ares-dev libcurl4-openssl-dev xsltproc docbook docbook-xsl uuid-dev zlib1g-dev libhiredis-dev curl libsqlite3-dev'; \
    mkdir -p /var/lib/mosquitto && \
    touch /var/lib/mosquitto/.keep && \
    mkdir -p /etc/mosquitto.d && \
    apt-get update -q && \
    apt-get install -qy $buildDeps openssl libc-ares2 libcurl3 libhiredis0.10 --no-install-recommends && \
    curl -kL https://github.com/warmcat/libwebsockets/archive/v1.4-chrome43-firefox-36.tar.gz  | tar -zxvf - && \
    cd libwebsockets-1.4-chrome43-firefox-36/ && \
    mkdir build && \
    cd build && \
    cmake .. -DLWS_WITH_HTTP2=1 -DLWS_WITHOUT_TESTAPPS=1 && \
    make && \
    make install && \
    ldconfig -v && \
    cd / && rm -rf libwebsockets-1.4-chrome43-firefox-36/ && \
    git clone git://git.eclipse.org/gitroot/mosquitto/org.eclipse.mosquitto.git && \
    cd org.eclipse.mosquitto && \
    sed -i "s/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/" config.mk && \
    make && \
    make install && \
    git clone git://github.com/jpmens/mosquitto-auth-plug.git && \
    cd mosquitto-auth-plug && \
    cp config.mk.in config.mk && \
    sed -i "s/BACKEND_REDIS ?= no/BACKEND_REDIS ?= yes/" config.mk && \
    sed -i "s/BACKEND_HTTP ?= no/BACKEND_HTTP ?= yes/" config.mk && \
    sed -i "s/BACKEND_MYSQL ?= yes/BACKEND_MYSQL ?= no/" config.mk && \
    sed -i "s/MOSQUITTO_SRC = /MOSQUITTO_SRC = ..\/org.eclipse.mosquitto\//" config.mk && \
    make && \
    cp auth-plug.so /usr/local/lib/ && \
    cp np /usr/local/bin/ && chmod +x /usr/local/bin/np && \
    cd / && rm -rf org.eclipse.mosquitto && \
    cd / && rm -rf mosquitto-auth-plug && \
    apt-get purge -y --auto-remove $buildDeps


ADD mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["mosquitto"]

