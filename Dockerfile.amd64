FROM amd64/alpine

ENV RCLONE_VER=1.49.5 \
    BUILD_DATE=20191024T205553 \
    ARCH=amd64 \
    SUBCMD="" \
    CONFIG="--config /config/rclone.conf" \
    PARAMS=""

LABEL build_version="Version:- ${RCLONE_VER} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Lucas Halbert <lhalbert@lhalbert.xyz>"
MAINTAINER Lucas Halbert <lhalbert@lhalbert.xyz>


RUN apk add --no-cache --update ca-certificates fuse fuse-dev unzip curl mdocml-apropos curl-doc && \
    curl -O https://downloads.rclone.org/v${RCLONE_VER}/rclone-v${RCLONE_VER}-linux-${ARCH}.zip && \
    unzip rclone-v${RCLONE_VER}-linux-${ARCH}.zip && \
    cd rclone-*-linux-${ARCH} && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    mkdir -p /usr/share/man/man1 && \
    cp rclone.1 /usr/share/man/man1/ && \
    makewhatis /usr/share/man && \
    apk del --purge unzip curl && \
    cd ../ && \
    rm -f rclone-v${RCLONE_VER}-linux-${ARCH}.zip && \
    rm -r rclone-*-linux-${ARCH}


COPY docker-entrypoint.sh /usr/bin/


ENTRYPOINT ["docker-entrypoint.sh"]
