#!/bin/bash

set -euox pipefail

if [ ! -f /appdata/tautulli/config ]; then
    sudo mkdir -p /appdata/tautulli/config
    sudo chown -R plex:plex /appdata/tautulli/config
fi

docker stop tautulli || true
docker rm tautulli || true


# https://github.com/linuxserver/docker-tautulli
docker create \
  --name=tautulli \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 8181:8181 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /appdata/tautulli/config:/config \
  -v /appdata/plex/config/Library/Application\ Support/Plex\ Media\ Server/Logs:/logs:ro \
  --restart unless-stopped \
  linuxserver/tautulli


docker start tautulli
