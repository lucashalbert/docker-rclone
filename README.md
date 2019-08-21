[appurl]: https://rclone.org
[microbadger]: https://microbadger.com/images/lucashalbert/docker-rclone
[dockerstore]: https://store.docker.com/community/images/lucashalbert/docker-rclone
# docker-rclone
---
![Travis-CI Build Status](https://travis-ci.org/lucashalbert/docker-rclone.svg?branch=master) [![Docker Layers](https://images.microbadger.com/badges/image/lucashalbert/docker-rclone.svg)][microbadger] [![Docker Pulls](https://img.shields.io/docker/pulls/lucashalbert/docker-rclone.svg)][dockerstore] [![Docker Stars](https://img.shields.io/docker/stars/lucashalbert/docker-rclone.svg)][dockerstore]


A multi-architecture rclone image built on alpine linux. This image is compatible with arm32v6, arm32v7, arm64v8, and x86_64.
---

## Usage
```
docker create \
    --name=rclone \
    --privileged \
    -v $(pwd)/config:/config \
    -v $(pwd)/mnt:/mnt \
    --env CONFIG="--config /config/rclone.conf" \
    --env SUBCMD="mount" \
    --env PARAMS="--allow-other --allow-non-empty gcrypt: /mnt/" lucashalbert/docker-rclone

docker start rclone

docker exec -it rclone sh

docker stop rclone

docker rm rclone
```

## Environment Variables / Parameters
|Variable|Example|Description|
|---|---|---|
|SUBCMD|mount|Rclone subcommand (see [Subcommands](https://rclone.org/docs/#subcommands) section of rclone documentation)|
|CONFIG|--config /config/rclone.conf|Location of the rclone configuration file|
|PARAMS|--allow-others --allow-non-empty |Options to be passed to rclone|
