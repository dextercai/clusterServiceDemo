FROM golang:alpine AS builder

LABEL stage=gobuilder

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOPROXY https://goproxy.cn,direct

WORKDIR /workdir/

ADD go.mod .
ADD go.sum .
RUN go mod download
COPY . .
RUN apk add git make
RUN make build

FROM alpine:latest
RUN apk update --no-cache && apk add --no-cache ca-certificates tzdata wget curl
ENV TZ Asia/Shanghai
ENV Author DexterCai
ENV Project clusterServiceDemo

WORKDIR /app
COPY --from=builder /build/clusterServiceDemo /app/clusterServiceDemo
EXPOSE 3000
CMD ["/app/clusterServiceDemo"]