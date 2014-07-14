FROM jllopis/busybox
MAINTAINER Joan Llopis <jllopisg@gmail.com>
ADD mosquitto.tar.gz /
ADD mosquitto.conf /etc/mosquitto/mosquitto.conf
RUN adduser -SDH mosquitto

EXPOSE 1883

VOLUME ["/var/lib/mosquitto", "/etc/mosquitto", "/etc/mosquitto.d"]

ENTRYPOINT ["/usr/sbin/mosquitto"]
CMD ["-c", "/etc/mosquitto/mosquitto.conf"]
