#!/bin/bash

set -e
set -x

IMAGE=quay.io/che-incubator/devfile-development-assistant:latest

podman build -t "${IMAGE}" .
podman push "${IMAGE}"