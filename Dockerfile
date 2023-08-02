FROM golang:1.15-alpine as builder

WORKDIR /go/src/drone-email
COPY . .

RUN GOOS=linux GOARM=7 GOARCH=${TARGETARCH} CGO_ENABLED=0 go build

FROM alpine:3.15

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /go/src/drone-email/drone-email /bin/
ENTRYPOINT ["/bin/drone-email"]
