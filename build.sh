#!/bin/bash

set -e

init() {
  unset IMAGE

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      '--image'|'-i') IMAGE="$2"; shift 1;;
    esac
    shift 1
  done
}

run() {
  [[ -z ${IMAGE} ]] && { echo "[ERROR] Image is not defined"; exit 1; }

  echo "[INFO] Building..."
  podman build -t "${IMAGE}" .
  podman push "${IMAGE}"
  echo "[INFO] Completed"
}

init "$@"
run

