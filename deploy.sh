#!/bin/bash

set -e

init() {
  unset OPENAI_API_KEY
  unset ASSISTANT_ID
  unset NAMESPACE
  unset IMAGE

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      '--openai-api-key'|'-k') OPENAI_API_KEY="$2"; shift 1;;
      '--image'|'-i') IMAGE="$2"; shift 1;;
      '--assistant'|'-a') ASSISTANT_ID="$2"; shift 1;;
      '--namespace'|'-n') NAMESPACE="$2"; shift 1;;
    esac
    shift 1
  done
}

run() {
  [[ -z ${IMAGE} ]] && { echo "[ERROR] Image is not defined"; exit 1; }
  [[ -z ${NAMESPACE} ]] && { echo "[ERROR] Namespace is not defined"; exit 1; }
  [[ -z ${OPENAI_API_KEY} ]] && { echo "[ERROR] OpenAI API Key is not defined"; exit 1; }

  kubectl create namespace ${NAMESPACE} || true

  kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/part-of: devfile-assistant
  name: devfile-assistant
  namespace: ${NAMESPACE}
stringData:
  openai-key: ${OPENAI_API_KEY}
  assistant-id: ${ASSISTANT_ID}
EOF

  kubectl apply -f deploy/deployment/kubernetes/objects/devfile-assistant.ServiceAccount.yaml -n "${NAMESPACE}"
  kubectl apply -f deploy/deployment/kubernetes/objects/devfile-assistant.Service.yaml -n "${NAMESPACE}"

  cat deploy/deployment/kubernetes/objects/devfile-assistant.Deployment.yaml | \
    sed 's|image:.*|image: '${IMAGE}'|g' | \
    kubectl apply -n "${NAMESPACE}" -f -

  echo "[INFO] Completed"
}

init "$@"
run

