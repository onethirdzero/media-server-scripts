#!/bin/bash

set -euox pipefail

if [ ! -f /appdata/jackett/config ]; then
    sudo mkdir -p /appdata/jackett/config
    sudo chown -R plex:plex /appdata/jackett/config
fi
# https://www.reddit.com/r/torrents/comments/7sht4b/what_is_a_torrent_black_hole/
if [ ! -f /appdata/jackett/torrent-blackhole ]; then
    sudo mkdir -p /appdata/jackett/torrent-blackhole
    sudo chown -R plex:plex /appdata/jackett/torrent-blackhole
fi

docker stop jackett || true
docker rm jackett || true

# https://github.com/linuxserver/docker-jackett
docker create \
  --name=jackett \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -e AUTO_UPDATE=true \
  -p 9117:9117 \
  -v /appdata/jackett/config:/config \
  -v /appdata/jackett/torrent-blackhole:/downloads \
  --restart unless-stopped \
  linuxserver/jackett

docker start jackett
