DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=1.4.4

all:
	@echo "Mosquitto version: v1.4.4"
	@echo ""
	@echo "Commands:"
	@echo "  make image : build the mosquitto image"

image:
	@echo "Building mosquitto image"
	${DOCKER} build --no-cache -t ${REPOSITORY}:${TAG} .

