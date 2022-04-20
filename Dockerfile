FROM alpine:latest as tailscale
ARG TAILSCALE_VERSION=1.22.2
ENV TSFILE=tailscale_${TAILSCALE_VERSION}_amd64.tgz
WORKDIR /tailscale
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1

FROM alpine:latest
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
WORKDIR /tailscale
COPY --from=tailscale /tailscale/tailscaled /tailscale/tailscaled
COPY --from=tailscale /tailscale/tailscale /tailscale/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale
COPY entrypoint.sh /tailscale/entrypoint.sh 

# Run on container startup.
ENTRYPOINT ["/tailscale/entrypoint.sh"]
