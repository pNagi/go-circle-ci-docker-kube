#!/bin/bash

# Exit on any error
set -e

curl https://sdk.cloud.google.com | bash
exec -l $SHELL

sudo /opt/google-cloud-sdk/bin/gcloud docker push gcr.io/firsttry-178217/go-circleci-docker-kube
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
# kubectl patch deployment docker-hello-google -p '{"spec":{"template":{"spec":{"containers":[{"name":"docker-hello-google","image":"gcr.io/firsttry-178217/go-circleci-docker-kube:'"$CIRCLE_SHA1"'"}]}}}}'

docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.8 go test
