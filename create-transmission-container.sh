#!/bin/bash

set -euox pipefail

if [ ! -f /appdata/transmission/config ]; then
    sudo mkdir -p /appdata/transmission/config
    sudo chown -R plex:plex /appdata/transmission/config
fi
if [ ! -f /appdata/transmission/downloads ]; then
    sudo mkdir -p /appdata/transmission/downloads
    sudo chown -R plex:plex /appdata/transmission/downloads
fi

docker stop transmission || true
docker rm transmission || true

# https://github.com/linuxserver/docker-transmission
docker create \
  --name=transmission \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TRANSMISSION_WEB_HOME=/transmission-web-control/ \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /etc/localtime:/etc/localtime:ro \
  -v /appdata/transmission/config:/config \
  -v /appdata/transmission/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/transmission

docker start transmission
