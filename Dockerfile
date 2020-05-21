FROM amd64/alpine

ENV RCLONE_VER=1.51.0 \
    BUILD_DATE=20200521T175740 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    ARCH=amd64 \
    SUBCMD="" \
    CONFIG="--config /config/rclone.conf" \
    PARAMS=""

LABEL build_version="Version:- ${RCLONE_VER} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Lucas Halbert <lhalbert@lhalbert.xyz>"
MAINTAINER Lucas Halbert <lhalbert@lhalbert.xyz>


# Add s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v2.0.0.1/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

RUN apk add --no-cache --update ca-certificates fuse fuse-dev unzip curl mdocml-apropos curl-doc bash shadow && \
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
    rm -rf /var/cache/apk/* /tmp/* && \
    cd ../ && \
    rm -f rclone-v${RCLONE_VER}-linux-${ARCH}.zip && \
    rm -r rclone-*-linux-${ARCH} && \
    groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false abc && \
    usermod -G users abc

# Add s6-overlay configs
ADD ./etc /etc


# s6 overlay entrypoint
ENTRYPOINT ["/init"]
