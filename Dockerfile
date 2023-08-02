FROM golang:1.18-alpine as builder

WORKDIR /go/src/drone-email
COPY . .

RUN GOOS=linux GOARCH=${TARGETARCH} CGO_ENABLED=0 go build

FROM alpine:3.18

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /go/src/drone-email/drone-email /bin/
ENTRYPOINT ["/bin/drone-email"]
