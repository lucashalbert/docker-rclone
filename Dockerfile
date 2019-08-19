FROM alpine:amd64

ENV WORKDIR=/tmp \
    VERSION=0.0.1 \
    BUILD_DATE= \
    ARCH=amd64

LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="lucashalbert"

RUN apk add --no-cache --update bash fuse fuse-dev unzip curl mdocml-apropos curl-doc

RUN curl -O https://downloads.rclone.org/rclone-current-linux-${ARCH}.zip && \
    unzip rclone-current-linux-${ARCH}.zip && \
    cd rclone-*-linux-${ARCH} && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    mkdir -p /usr/share/man/man1 && \
    cp rclone.1 /usr/share/man/man1/ && \
    makewhatis /usr/share/man

WORKDIR ${WORKDIR}

COPY docker-entrypoint.sh ${WORKDIR}/

ENTRYPOINT ["./docker-entrypoint.sh"]
