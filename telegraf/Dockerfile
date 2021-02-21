FROM golang:1.16-buster as build
RUN go get github.com/pridkett/cookieproxy

FROM telegraf:1.17

RUN apt-get update
RUN apt-get install -y cron

COPY --from=build /go/bin/cookieproxy .
COPY cookieproxy.sh /etc/init.d/cookieproxy
COPY entrypoint.sh /
