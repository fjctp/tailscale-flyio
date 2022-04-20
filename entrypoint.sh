#!/bin/sh

/tailscale/tailscaled --tun=userspace-networking &
until /tailscale/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=cloudrun-app ${@:1}
do
  sleep 0.1
done

echo "Tailscale started"

sleep infinity
