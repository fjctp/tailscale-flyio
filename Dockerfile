FROM golang:1.17-alpine3.15 as builder
WORKDIR /app
COPY ./src ./
RUN go build

FROM alpine:latest as tailscale
ARG TAILSCALE_VERSION=1.22.2
ENV TSFILE=tailscale_${TAILSCALE_VERSION}_amd64.tgz
WORKDIR /tailscale
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/http_server /app/http_server
COPY --from=tailscale /tailscale/tailscaled /app/tailscaled
COPY --from=tailscale /tailscale/tailscale /app/tailscale
RUN mkdir -p /var/run/tailscale 
RUN mkdir -p /var/cache/tailscale
RUN mkdir -p /var/lib/tailscale
COPY entrypoint.sh /entrypoint.sh 

# Run on container startup.
ENTRYPOINT ["/entrypoint.sh"]
