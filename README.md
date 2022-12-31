# tailscale-cloudrun
Run an exit node on google cloud run service

## build docker image

```
TAILSCALE_VERSION=1.34.1
docker build \
  --build-arg TAILSCALE_VERSION=${TAILS_SCALE} \
  -t fjctp/tailscale:$TAILSCALE_VERSION .

docker tag fjctp/tailscale:$TAILSCALE_VERSION \
  us-west1-docker.pkg.dev/tailscale-cloudrun/tailscale/tailscale:$TAILSCALE_VERSION

docker push us-west1-docker.pkg.dev/tailscale-cloudrun/tailscale/tailscale:$TAILSCALE_VERSION
```

## run as an exit node
```
TAILSCALE_AUTHKEY=XXXXXX
docker run -d \
  --name tailscale \
  --env TAILSCALE_AUTHKEY=${TAILSCALE_AUTHKEY} \
  fjctp/tailscale:v$TAILSCALE_VERSION --advertise-exit-node
```
