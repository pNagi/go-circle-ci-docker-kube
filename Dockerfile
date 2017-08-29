FROM golang:1.9

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/pNagi/go-circleci-docker-kube
RUN go install github.com/pNagi/go-circleci-docker-kube

ENTRYPOINT /go/bin/go-circleci-docker-kube
EXPOSE 9090