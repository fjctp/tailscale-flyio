#!/bin/sh

/app/tailscaled --tun=userspace-networking &
until /app/tailscale up \
  --hostname=exit-node \
  --authkey="${TAILSCALE_AUTHKEY}" \
  --advertise-exit-node ${@:1}
do
  sleep 0.1
done

echo "Tailscale started"
sleep infinity
