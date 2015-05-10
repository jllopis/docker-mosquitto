DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=latest

image:
	@echo "Building mosquitto image"
	${DOCKER} build -t ${REPOSITORY}:${TAG} .

