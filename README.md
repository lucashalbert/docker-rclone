[rclone-home]: https://rclone.org
[travis]: https://travis-ci.org/lucashalbert/docker-rclone
[microbadger]: https://microbadger.com/images/lucashalbert/docker-rclone
[dockerstore]: https://store.docker.com/community/images/lucashalbert/docker-rclone
# docker-rclone
A multi-architecture rclone image built on alpine linux. This image is compatible with arm32v6, arm32v7, arm64v8, and x86_64.

![Travis-CI Build Status](https://travis-ci.org/lucashalbert/docker-rclone.svg?branch=master)
[![Docker Layers](https://images.microbadger.com/badges/image/lucashalbert/docker-rclone.svg)][microbadger]
[![Docker Pulls](https://img.shields.io/docker/pulls/lucashalbert/docker-rclone.svg)][dockerstore]
[![Docker Stars](https://img.shields.io/docker/stars/lucashalbert/docker-rclone.svg)][dockerstore]

## Rclone
Excerpt from the rclone [homepage][rclone-home].

![Rclone](https://rclone.org/img/rclone-120x120.png)

Rclone is a command line program to sync files and directories to and from:

* Alibaba Cloud (Aliyun) Object Storage System (OSS)  
* Amazon Drive   (See note)
* Amazon S3  
* Backblaze B2  
* Box  
* Ceph  
* DigitalOcean Spaces  
* Dreamhost  
* Dropbox  
* FTP  
* Google Cloud Storage  
* Google Drive  
* HTTP  
* Hubic  
* Jottacloud  
* IBM COS S3  
* Koofr  
* Memset Memstore  
* Mega  
* Microsoft Azure Blob Storage  
* Microsoft OneDrive  
* Minio  
* Nextcloud  
* OVH  
* OpenDrive  
* Openstack Swift  
* Oracle Cloud Storage  
* ownCloud  
* pCloud  
* put.io  
* QingStor  
* Rackspace Cloud Files  
* rsync.net  
* Scaleway  
* SFTP  
* Wasabi  
* WebDAV  
* Yandex Disk  
* The local filesystem  

Features
* MD5/SHA1 hashes checked at all times for file integrity
* Timestamps preserved on files
* Partial syncs supported on a whole file basis
* Copy mode to just copy new/changed files
* Sync (one way) mode to make a directory identical
* Check mode to check for file hash equality
* Can sync to and from network, eg two different cloud accounts
* Encryption backend
* Cache backend
* Union backend
* Optional FUSE mount (rclone mount)
* Multi-threaded downloads to local disk
* Can serve local or remote files over HTTP/WebDav/FTP/SFTP/dlna
---
## docker-rclone Container Usage
#### Create/Delete rclone container
Create
```
docker create \
    --name=rclone \
    --privileged \
    -v $(pwd)/config:/config \
    -v $(pwd)/mnt:/mnt:shared \
    --env CONFIG="--config /config/rclone.conf" \
    --env SUBCMD="mount" \
    --env PARAMS="--allow-other --allow-non-empty gcrypt: /mnt/" lucashalbert/docker-rclone
```
Delete
```
docker rm rclone
```
#### Start/Stop rclone container
Start
```
docker start rclone
```
Stop
```
docker stop rclone
```
#### Access shell while rclone container is running
```
docker exec -it rclone sh
```

## Environment Variables / Parameters
|Variable|Example|Description|
|---|---|---|
|SUBCMD|mount|Rclone subcommand (see [Subcommands](https://rclone.org/docs/#subcommands) section of rclone documentation)|
|CONFIG|--config /config/rclone.conf|Location of the rclone configuration file|
|PARAMS|--allow-others --allow-non-empty |Options to be passed to rclone|

