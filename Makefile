.PHONY: help
.DEFAULT_GOAL := help

DOCKER=$(shell which docker)
REPOSITORY?=jllopis/mosquitto
TAG?=v1.5.5

image: ## build the docker image from Dockerfile
	$(DOCKER) build --no-cache -t ${REPOSITORY}:${TAG} .

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'