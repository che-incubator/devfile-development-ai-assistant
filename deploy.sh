#!/bin/bash

set -e
set -x

init() {
  unset OPENAI_API_KEY
  unset ASSISTANT_ID
  unset NAMESPACE

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      '--openai-api-key'|'-k') OPENAI_API_KEY="$2"; shift 1;;
      '--assistant-id'|'-a') ASSISTANT_ID="$2"; shift 1;;
      '--namespace'|'-n') NAMESPACE="$2"; shift 1;;
    esac
    shift 1
  done
}

run() {
  kubectl create namespace eclipse-che
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

  kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: devfile-assistant-url
  namespace: ${NAMESPACE}
  annotations:
    che.eclipse.org/env-name: DEVFILE_ASSISTANT_URL
    che.eclipse.org/mount-as: env
  labels:
    app.kubernetes.io/part-of: che.eclipse.org
    app.kubernetes.io/component: che-dashboard-configmap
data:
  devfile-assistant-url: "http://devfile-assistant.${NAMESPACE}.svc:9000/"
EOF

  kubectl apply -f deploy/deployment/kubernetes/objects/devfile-assistant.ServiceAccount.yaml -n "${NAMESPACE}"
  kubectl apply -f deploy/deployment/kubernetes/objects/devfile-assistant.Service.yaml -n "${NAMESPACE}"
  kubectl apply -f deploy/deployment/kubernetes/objects/devfile-assistant.Deployment.yaml -n "${NAMESPACE}"
}

init "$@"
run

