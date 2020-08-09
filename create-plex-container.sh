#!/bin/bash

set -euox pipefail

if [ ! -f /appdata/plex/config ]; then
    sudo mkdir -p /appdata/plex/config
    sudo chown -R plex:plex /appdata/plex/config
fi
if [ ! -f /appdata/plex/tv ]; then
    sudo mkdir -p /appdata/plex/tv
    sudo chown -R plex:plex /appdata/plex/tv
fi
if [ ! -f /appdata/plex/movies ]; then
    sudo mkdir -p /appdata/plex/movies
    sudo chown -R plex:plex /appdata/plex/movies
fi

docker stop plex || true
docker rm plex || true

# https://github.com/linuxserver/docker-plex
docker create \
    --name=plex \
    --net=host \
    -e PUID=1001 \
    -e PGID=1001 \
    -e VERSION=docker \ # Let Docker handle the versioning.
    -v /etc/localtime:/etc/localtime:ro \
    -v /appdata/plex/config:/config \
    -v /appdata/plex/tv:/tv \
    -v /appdata/plex/movies:/movies \
    --restart unless-stopped \
    linuxserver/plex

docker start plex
