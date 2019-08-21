#!/bin/sh

#/usr/bin/rclone mount ${RCLONE_CONFIG_OPTS} ${RCLONE_OPTS} gcrypt: /mnt/

/usr/bin/rclone ${SUBCMD} ${CONFIG} ${PARAMS}
