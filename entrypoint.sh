#!/bin/sh

/app/tailscaled --tun=userspace-networking &
until /app/tailscale up --authkey=${TAILSCALE_AUTHKEY} \
  --hostname=cloudrun-app ${@:1}
do
  sleep 0.1
done

echo "Tailscale started"

# a dummy http server that listen to $PORT
/app/http_server
