FROM golang:1.9

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/pNagi/go-circleci-docker-kube
RUN cd /go/src/github.com/pNagi/go-circleci-docker-kube && go get ./

ENTRYPOINT /go/bin/go-circleci-docker-kube
EXPOSE 9090
