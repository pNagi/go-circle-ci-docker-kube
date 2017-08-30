#!/bin/bash

# Exit on any error
set -e

docker build -f Dockerfile -t gcr.io/firsttry-178217/go-circleci-docker-kube:$CIRCLE_SHA1 .
sudo /opt/google-cloud-sdk/bin/gcloud docker push gcr.io/firsttry-178217/go-circleci-docker-kube:$CIRCLE_SHA1
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
# kubectl patch deployment docker-hello-google -p '{"spec":{"template":{"spec":{"containers":[{"name":"go-circleci-docker-kube","image":"gcr.io/firsttry-178217/go-circleci-docker-kube:'"$CIRCLE_SHA1"'"}]}}}}'
