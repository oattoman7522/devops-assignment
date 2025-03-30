FROM golang:1.24 AS build-go

WORKDIR /app

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o devops-test

FROM alpine:latest  

WORKDIR /app

COPY --from=build-go /app/devops-test /app/

CMD ["/app/devops-test"]