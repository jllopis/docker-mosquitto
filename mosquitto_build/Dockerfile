FROM ubuntu:14.04
ENV BUILDROOT_VERSION 2014.05
ENV TERM dumb
RUN locale-gen es_ES.UTF-8
ENV LANG es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q
RUN apt-get install -qy wget build-essential bzip2 git libwrap0-dev libssl-dev libc-ares-dev xsltproc docbook docbook-xsl
RUN git clone git://git.eclipse.org/gitroot/mosquitto/org.eclipse.mosquitto.git
WORKDIR org.eclipse.mosquitto
RUN make && make install && \
    mkdir /mosquis && \
    mkdir -p /mosquis/etc/mosquitto && \
    mkdir -p /mosquis/etc/mosquitto.d && \
    mkdir -p /mosquis/usr/bin /mosquis/usr/include /mosquis/usr/lib /mosquis/usr/sbin && \
    cp -a /usr/local/bin/mosquitto* /mosquis/usr/bin && \
    cp -a /usr/local/sbin/mosquitto /mosquis/usr/sbin && \
    cp -a /usr/local/include/mosquitto* /mosquis/usr/include && \
    cp -a /usr/local/lib/libmosquitto* /mosquis/usr/lib
RUN cd /mosquis && tar -zcvf /mosquitto.tar.gz .
WORKDIR /
RUN rm -rf /mosquis
