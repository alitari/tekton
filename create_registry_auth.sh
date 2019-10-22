#!/bin/bash
registry="https://index.docker.io"
read -p "Authentication user for docker registry: '$registry':"  username
read -s -p "Enter Password: " pswd
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Secret
metadata:
  name: registry-auth
  annotations:
    tekton.dev/docker-0: $registry
type: kubernetes.io/basic-auth
stringData:
  username: $username
  password: $pswd
EOF
