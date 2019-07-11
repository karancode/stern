FROM golang AS build-env
LABEL maintainer="stern <http://wercker.com>"

WORKDIR $GOPATH/src/github.com/wercker/stern
RUN go get -u github.com/kardianos/govendor
COPY . .
RUN govendor sync && CGO_ENABLED=0 go build -o /bin/stern

FROM alpine

COPY --from=build-env /bin/stern /bin

ENTRYPOINT [ "stern" ]