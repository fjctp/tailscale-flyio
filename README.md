# tailscale-cloudrun
Run an exit node on google cloud run service

## build docker image

```
TAILSCALE_VERSION=1.22.2
docker build \
  --build-arg TAILSCALE_VERSION=${TAILS_SCALE} \
  -t fjctp/tailscale:1.22.2 .

docker tag fjctp/tailscale:1.22.2 \
  us-west1-docker.pkg.dev/tailscale-cloudrun/tailscale/tailscale:1.22.2

docker push us-west1-docker.pkg.dev/tailscale-cloudrun/tailscale/tailscale:1.22.2
```

## run as an exit node
```
TAILSCALE_AUTHKEY=XXXXXX
docker run -d \
  --name tailscale \
  --env TAILSCALE_AUTHKEY=${TAILSCALE_AUTHKEY} \
  fjctp/tailscale:v1.22.2 --advertise-exit-node
```
