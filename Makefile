DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=v1.4.9

all:
	@echo "Mosquitto version: ${TAG}"
	@echo ""
	@echo "Commands:"
	@echo "  make image : build the mosquitto image"

image:
	@echo "Building mosquitto image"
	${DOCKER} build --no-cache -t ${REPOSITORY}:${TAG} .

