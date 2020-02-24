#!make

-include .env

.DEFAULT_GOAL	:= build
MOLECULE_DISTRO := $(DIST):$(VERSION)
TARGET 			:= kilip/molecule-$(DIST):$(VERSION)

export TARGET
export MOLECULE_DISTRO

build:
	docker build --build-arg VERSION=$(VERSION) -t $(TARGET) -f dist/$(DIST)/Dockerfile .

create:
	cd test; \
	molecule create;

converge:
	cd test; \
	molecule converge; \

login:
	cd test; \
	molecule login;

verify:
	cd test; \
	molecule verify;

destroy:
	cd test; \
	molecule destroy;

molecule-test:
	cd test; \
	molecule test;

push:
	echo "$(DOCKER_PASSWORD)" |  docker login -u "$(DOCKER_USERNAME)" --password-stdin
	docker push $(TARGET)
