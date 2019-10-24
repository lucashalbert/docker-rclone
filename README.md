[rclone-home]: https://rclone.org
[rclone-logo]: https://rclone.org/img/logo_on_dark__horizontal_color.svg
[travis]: https://travis-ci.org/lucashalbert/docker-rclone
[microbadger]: https://microbadger.com/images/lucashalbert/docker-rclone
[dockerstore]: https://store.docker.com/community/images/lucashalbert/docker-rclone
# docker-rclone
A multi-architecture rclone image built on alpine linux. This image is compatible with arm32v6, arm32v7, arm64v8, and x86_64.

[![Travis-CI Build Status](https://travis-ci.org/lucashalbert/docker-rclone.svg?branch=master)][travis]
[![Docker Layers](https://images.microbadger.com/badges/image/lucashalbert/docker-rclone.svg)][microbadger]
[![Docker Pulls](https://img.shields.io/docker/pulls/lucashalbert/docker-rclone.svg)][dockerstore]
[![Docker Stars](https://img.shields.io/docker/stars/lucashalbert/docker-rclone.svg)][dockerstore]

[![Rclone][rclone-logo]][rclone-home]]
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
# Container Usage

#### Interactively Create an rclone configuration
```
sudo docker run -it \
    -v $(pwd)/config:/config \
     --entrypoint=rclone \
     lucashalbert/docker-rclone:latest \
     --config /config/rclone.conf config
```
##### Example Google Drive Rclone Configuration
```
[gdrive]
type = drive
client_id = 9812619862124-kjsadfkjasdflkjashdfkljashfkadjh.apps.googleusercontent.com
client_secret = KaJadHasdGAqafhKJUoakaGs
scope = drive
hdlkahsdlkhiuhgsiKJHSA_jkasdkjhaskjha_qe","expiry":"2018-06-14T10:13:20.424623462Z"}
team_drive = 0AaskdjhasKJGaskjdh

[gcache]
type = cache
remote = gdrive:
chunk_size = 5M
info_age = 1d
chunk_total_size = 1G

[gcache-crypt]
type = crypt
remote = gcache:
filename_encryption = standard
directory_name_encryption = true
password = lakldhfkuhaehadf7hkajdfhl29hrkljhasd9hDFKHASEDFMN.O3RNDLF8ADFLK3LIHslhD97HFADONLKLNkjHkljhlkjhfknadofadflkjqlkasd
password2 = adlkfhadflakhdf98had87hih&HKjhaslhsadkjgo8gi7KJlkjglgfG&aslkdhlkjgkljGLKJGSADkjhlkhasdlkhasd

[gdrive-crypt]
type = crypt
remote = gdrive:
filename_encryption = standard
directory_name_encryption = true
password = lakldhfkuhaehadf7hkajdfhl29hrkljhasd9hDFKHASEDFMN.O3RNDLF8ADFLK3LIHslhD97HFADONLKLNkjHkljhlkjhfknadofadflkjqlkasd
password2 = adlkfhadflakhdf98had87hih&HKjhaslhsadkjgo8gi7KJlkjglgfG&aslkdhlkjgkljGLKJGSADkjhlkhasdlkhasd
```

#### Mount a remote drive 
```
docker run --privileged \
    -v $(pwd)/config:/config \
    -v $(pwd)/mnt:/mnt:shared \
    --env CONFIG="--config /config/rclone.conf" \
    --env SUBCMD="mount" \
    --env PARAMS="--allow-other --allow-non-empty gdrive-crypt: /mnt/" lucashalbert/docker-rclone
```

#### Copy files from local system to remote
```
docker run --privileged \
    -v $(pwd)/config:/config \
    -v $(pwd)/mnt:/mnt:shared \
    --env CONFIG="--config /config/rclone.conf" \
    --env SUBCMD="copy" \
    --env PARAMS="-v /mnt/Pictures gdrive-crypt:/Pictures"
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
