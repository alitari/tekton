#!/bin/bash
INGRESS_CONTROLLER_IP=$(kubectl get service -l app=nginx-ingress,component=controller -o json | jq -r '.items[0].status.loadBalancer.ingress[0].ip')
echo "external ip is: $INGRESS_CONTROLLER_IP"
kubectl apply -f https://github.com/tektoncd/dashboard/releases/download/v0.2.0/release.yaml
cat <<EOF | kubectl create -f -
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tekton-dashboard
  namespace: default
spec:
  rules:
  - host: dashboard.${INGRESS_CONTROLLER_IP}.nip.io
    http:
      paths:
      - backend:
          serviceName: tekton-dashboard
          servicePort: 9097
EOF

echo "browse to dashboard with:'http://dashboard.${INGRESS_CONTROLLER_IP}.nip.io'"
