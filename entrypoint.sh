#!/bin/sh

/tailscale/tailscaled --tun=userspace-networking &
/tailscale/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=cloudrun-app ${@:1}
echo "Tailscale started"
fg