# syntax=docker/dockerfile:1
FROM golang:1.16-alpine

WORKDIR /server

COPY go.mod ./
COPY go.sum ./

RUN go mod download
COPY ./ ./

RUN go build -o /service_sonar

EXPOSE 9090

CMD [ "/service_sonar" ]