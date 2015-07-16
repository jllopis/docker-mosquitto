FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

EXPOSE 1883
EXPOSE 9883

VOLUME ["/var/lib/mosquitto", "/etc/mosquitto", "/etc/mosquitto.d"]

RUN groupadd -r mosquitto && \
    useradd -r -g mosquitto mosquitto
ENV BUILD_DEPS="wget build-essential cmake bzip2 mercurial git libwrap0-dev libssl-dev libc-ares-dev xsltproc docbook docbook-xsl uuid-dev zlib1g-dev libhiredis-dev libsqlite3-dev"

RUN buildDeps='wget build-essential cmake bzip2 mercurial git libwrap0-dev libssl-dev libc-ares-dev xsltproc docbook docbook-xsl uuid-dev zlib1g-dev libhiredis-dev libsqlite3-dev'; \
    mkdir -p /var/lib/mosquitto && \
    touch /var/lib/mosquitto/.keep && \
    apt-get update -q && \
    apt-get install -qy $buildDeps openssl --no-install-recommends && \
    apt-get install -qy curl libwebsockets3 libcurl3 libcurl4-openssl-dev libwebsockets-dev && \
    ldconfig -v && \
    echo "OK"
RUN cd / && rm -rf libwebsockets-1.4-chrome43-firefox-36/ && \
    git clone git://git.eclipse.org/gitroot/mosquitto/org.eclipse.mosquitto.git && \
    cd org.eclipse.mosquitto && \
    sed -i "s/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/" config.mk && \
    make && \
    make install && \
    ldconfig -v && \
    echo "MOSQUITTO INSTALLED"

# cd / && rm -rf org.eclipse.mosquitto && \
#

RUN cd / && \
    git clone git://github.com/jpmens/mosquitto-auth-plug.git && \
    cd mosquitto-auth-plug && \
    cp config.mk.in config.mk && \
    sed -i "s/BACKEND_REDIS ?= no/BACKEND_REDIS ?= yes/" config.mk && \
    sed -i "s/BACKEND_HTTP ?= no/BACKEND_HTTP ?= yes/" config.mk && \
    sed -i "s/BACKEND_MYSQL ?= yes/BACKEND_MYSQL ?= no/" config.mk && \
    sed -i "s/MOSQUITTO_SRC = /MOSQUITTO_SRC = ..\/org.eclipse.mosquitto\//" config.mk && \
    make && \
    cp auth-plug.so /usr/local/lib/ && \
    echo "AUTH PLUGIN INSTALLED"

RUN echo "Everything compiled, cleaning up" && \
    cd / && rm -rf org.eclipse.mosquitto && \
    cd / && rm -rf mosquitto-auth-plug && \
    echo "Removing unneeded packages"

RUN apt-get purge -y --auto-remove $BUILD_DEPS


ADD mosquitto.conf /etc/mosquitto/mosquitto.conf
COPY run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["mosquitto"]

