#!make

-include .env

.DEFAULT_GOAL	:= build
MOLECULE_DISTRO := $(MOLECULE_DIST):$(MOLECULE_VERSION)
TARGET 			:= kilip/molecule-$(MOLECULE_DIST):$(MOLECULE_VERSION)

export TARGET
export MOLECULE_DISTRO

build:
	docker build --build-arg VERSION=$(MOLECULE_VERSION) -t $(TARGET) -f dist/$(MOLECULE_DIST)/Dockerfile .

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
