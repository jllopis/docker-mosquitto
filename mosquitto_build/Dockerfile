FROM ubuntu:14.04
ENV BUILDROOT_VERSION 2014.09
ENV TERM dumb
RUN locale-gen es_ES.UTF-8
ENV LANG es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q
RUN apt-get install -qy wget build-essential cmake bzip2 mercurial git libwrap0-dev libssl-dev libc-ares-dev xsltproc docbook docbook-xsl uuid-dev zlib1g-dev
RUN hg clone https://bitbucket.org/oojah/mosquitto
RUN wget http://git.warmcat.com/cgi-bin/cgit/libwebsockets/snapshot/libwebsockets-1.3-chrome37-firefox30.tar.gz && \
    tar -xzvf libwebsockets-1.3-chrome37-firefox30.tar.gz && \
    cd libwebsockets-1.3-chrome37-firefox30/ && \
    mkdir build && \
    cd build && \
    cmake .. -DOPENSSL_ROOT_DIR=/usr/bin/openssl && \
    make && \
    make install && \
    ldconfig -v
WORKDIR mosquitto
RUN hg pull && hg update 1.4 && \
    sed -i "s/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/" config.mk && \
    make && \
    make install && \
    mkdir /mosquis && \
    mkdir -p /mosquis/etc/mosquitto && \
    mkdir -p /mosquis/etc/mosquitto.d && \
    mkdir -p /mosquis/usr/bin /mosquis/usr/include /mosquis/usr/lib /mosquis/usr/sbin && \
    cp -a /usr/local/bin/mosquitto* /mosquis/usr/bin && \
    cp -a /usr/local/sbin/mosquitto /mosquis/usr/sbin && \
    cp -a /usr/local/include/mosquitto* /mosquis/usr/include && \
    cp -a /usr/local/lib/libmosquitto* /mosquis/usr/lib && \
    cp -a /lib/x86_64-linux-gnu/libuuid.so.1* /mosquis/usr/lib && \
    cp -a /usr/local/lib/libwebsockets.* /mosquis/usr/lib
RUN cd /mosquis && tar -zcvf /mosquitto.tar.gz .
WORKDIR /
RUN rm -rf /mosquis
