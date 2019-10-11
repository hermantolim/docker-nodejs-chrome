VERSION ?= 0.1.0
NAME ?= hermantolim/firefox-geckodriver-baseimage
LATEST_VERSION = latest
VERSION_ARG ?= $(VERSION)

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build --rm --network host -t $(NAME):$(VERSION_ARG) image

test:
	env NAME=$(NAME) VERSION=$(VERSION_ARG) ./test/runner.sh

tag_latest:
	docker tag $(NAME):$(VERSION_ARG) $(NAME):$(LATEST_VERSION)

release: test
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION_ARG); then echo "$(NAME) version $(VERSION_ARG) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag by creating an official GitHub release."

test_release:
	echo test_release
	env

test_master:
	echo test_master
	env
