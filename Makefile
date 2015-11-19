DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=1.4.5

all:
	@echo "Mosquitto version: v1.4.5"
	@echo ""
	@echo "Commands:"
	@echo "  make image : build the mosquitto image"

image:
	@echo "Building mosquitto image"
	${DOCKER} build --no-cache -t ${REPOSITORY}:${TAG} .

