# Switch to bash
SHELL=/bin/bash


# Parameters - defaulted
DOCKERHUB_REPO_NAME ?= ${USER}
IMAGE_NAME ?= $(shell basename ${PWD})
VERSION ?= $(shell cat VERSION)


# Derived or calculated
BUILD_DATE = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
FULL_IMAGE_NAME = ${DOCKERHUB_REPO_NAME}/${IMAGE_NAME}
FULL_IMAGE_NAME_AND_TAG = ${FULL_IMAGE_NAME}:${VERSION}
REPO_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
REPO_VERSION = $(shell git rev-parse HEAD)


default: image


image:
	docker image build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg REPO_BRANCH=${REPO_BRANCH} \
		--build-arg REPO_VERSION=${REPO_VERSION} \
		--build-arg VERSION=${VERSION} \
		--tag ${FULL_IMAGE_NAME_AND_TAG} \
		.
