DOCKER=docker
REPOSITORY?=jllopis/mosquitto
TAG?=1.4.3

all:
	@echo "Mosquitto version: v1.4.3"
	@echo ""
	@echo "Commands:"
	@echo "  make image : build debian mosquitto image"
	@echo "  make alp   : build alpine mosquitto image"

image:
	@echo "Building mosquitto image"
	${DOCKER} build --no-cache -t ${REPOSITORY}:${TAG} .

alp:
	@echo "Building mosquitto alpine image"
	${DOCKER} build -f ./alpine/Dockerfile --no-cache -t ${REPOSITORY}:alpine .

