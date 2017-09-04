#!/bin/bash

# Exit on any error
set -e

${HOME}/google-cloud-sdk/bin/gcloud docker -- push gcr.io/firsttry-178217/go-circleci-docker-kube:$CIRCLE_SHA1
${HOME}/google-cloud-sdk/bin/gcloud container images add-tag gcr.io/firsttry-178217/go-circleci-docker-kube:$CIRCLE_SHA1 gcr.io/firsttry-178217/go-circleci-docker-kube:latest
${HOME}/google-cloud-sdk/bin/kubectl --namespace dev patch deployment go-deployment -p '{"spec":{"template":{"spec":{"containers":[{"name":"go-deployment","image":"gcr.io/firsttry-178217/go-circleci-docker-kube:'"$CIRCLE_SHA1"'"}]}}}}'
