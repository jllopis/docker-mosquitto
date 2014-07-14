docker-mosquitto
================

Mosquitto MQTT Broker on Docker Image (under 8MB).

# Version

**mosquitto** v1.3.1

# Build

Use the provide _Makefile_ to build either, the **mosquitto** binaries or the full image.

The the binaries are built inside a docker container (Ubuntu 14.04) built for this. The binaries are extracted to a **mosquitto.tar.gz** file that will be injected to the final **mosquitto container**.

## Build the binaries

    $ sudo make mosquitto

Now you have a newly created **mosquitto.tar.gz** with the binaries installed. The tar file does not contain man pages nor any configuration file. See below to know how to add config files to the image.

## Build the Mosquitto docker image

    $ sudo make

It will use the existent **mosquitto.tar.gz** if it exist or will create a new one if it doesn't.

You can specify your repository and tag by 

    $ sudo make REPOSITORY=my_own_repo/mqtt TAG=v1.3.1

Default for **REPOSITORY** is **jllopis/mosquitto** (should change this) and for **TAG** is **latest**.

# Persistence and Configuration

If you want to use persistence for the container or just use a custom config file you must use **VOLUMES** from your host or better, data only containers.

The container has three directories that you can use:

- **/etc/mosquitto** to store _mosquitto_ configuration files
- **/etc/mosquitto.d** to store additional configuration files that will be loaded after _/etc/mosquitto/mosquitto.conf_
- **/var/lib/mosquitto** to persist the database

The logger outputs to **stderr** by default.

See the following examples for some guidance:

## Mapping host directories

    $ sudo docker run -ti \
      -v /tmp/mosquitto/etc/mosquitto:/etc/mosquitto \
      -v /tmp/mosquitto/etc/mosquitto.d:/etc/mosquitto.d \
      -v /tmp/mosquitto/var/lib/mosquitto:/var/lib/mosquitto 
      --name mqtt \
      -p 1883:1883 \
      jllopis/mosquitto

## Data Only Containers

You must create a container to hold the directories first:

    $ sudo docker run -d -v /etc/mosquitto -v /etc/mosquitto.d -v /var/lib/mosquitto --name mqtt_data busybox /bin/true

and then just use **VOLUMES_FROM** in your container:

    $ sudo docker run -ti \
      --volumes-from mqtt_data \
      --name mqtt \
      -p 1883:1883 \
      jllopis/mosquitto

