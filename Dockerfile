FROM golang:1.17-alpine

RUN apk add git musl-dev

ADD . /app/src

WORKDIR /app/src

# build & install server
RUN GO111MODULE=on CGO_ENABLED=0 go build -tags netgo -ldflags "-X github.com/dutchcoders/transfer.sh/cmd.Version=$(git describe --tags) -a -s -w -extldflags '-static'" -o /app/transfersh

WORKDIR /app

ENTRYPOINT ["/app/transfersh", "--listener", ":80"]
