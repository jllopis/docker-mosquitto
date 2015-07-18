DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=1.4.2

image:
	@echo "Building mosquitto image"
	${DOCKER} build --no-cache -t ${REPOSITORY}:${TAG} .

