#!/bin/bash

set -euox pipefail

if [ ! -f /appdata/radarr/config ]; then
    sudo mkdir -p /appdata/radarr/config
    sudo chown -R plex:plex /appdata/radarr/config
fi
if [ ! -f /appdata/radarr/movies ]; then
    sudo mkdir -p /appdata/radarr/movies
    sudo chown -R plex:plex /appdata/radarr/movies
fi

docker stop radarr || true
docker rm radarr || true

# https://github.com/linuxserver/docker-radarr
docker create \
  --name=radarr \
  -e PUID=1001 \
  -e PGID=1001 \
  -p 7878:7878 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /appdata/radarr/config:/config \
  -v /appdata/plex/movies:/movies \
  -v /appdata/transmission/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/radarr

docker start radarr
