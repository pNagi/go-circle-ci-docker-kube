#!/bin/bash

# Exit on any error
set -e

gcloud docker -- push gcr.io/firsttry-178217/go-circleci-docker-kube:$CIRCLE_SHA1
kubectl patch deployment hello-world -p '{"spec":{"template":{"spec":{"containers":[{"name":"hello-world","image":"gcr.io/firsttry-178217/go-circleci-docker-kube:'"$CIRCLE_SHA1"'"}]}}}}'
