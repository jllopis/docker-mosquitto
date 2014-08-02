DOCKER=docker
TMPMOSQDOC=tmpmosquitodock
TMPCONT=tmpmosquitocont
REPOSITORY?=jllopis/mosquitto
TAG?=latest

image: mosquitto
	@echo "Building mosquitto image"
	${DOCKER} build -t ${REPOSITORY}:${TAG} .

mosquitto:
	@cd mosquitto_build ; \
	@echo "Building mosquitto binaries inside docker" ; \
	${DOCKER} build -t ${TMPMOSQDOC} .                ; \
	${DOCKER} run --name ${TMPCONT} ${TMPMOSQDOC} cat mosquitto.tar.gz > ../mosquitto.tar.gz
	@echo "Done!"

clean:
	rm mosquitto.tar.gz             || true
	${DOCKER} rm ${TMPCONT}         || true
	${DOCKER} rmi ${TMPMOSQDOC}     || true
