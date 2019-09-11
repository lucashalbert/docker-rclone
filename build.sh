#!/bin/bash
rclone_ver=1.49.2
rclone_ver=${rclone_ver:-$(curl -s https://downloads.rclone.org/version.txt | cut -d"v" -f2)}
build_date=${build_date:-$(date +"%Y%m%dT%H%M%S")}

for docker_arch in amd64 arm32v6 arm64v8; do
    case ${docker_arch} in
        amd64   ) qemu_arch="x86_64"  rclone_arch="amd64" ;;
        arm32v6 ) qemu_arch="arm"     rclone_arch="arm"   ;;
        arm64v8 ) qemu_arch="aarch64" rclone_arch="arm64" ;;    
    esac
    cp Dockerfile.cross Dockerfile.${docker_arch}
    sed -i "s|__BASEIMAGE_ARCH__|${docker_arch}|g" Dockerfile.${docker_arch}
    sed -i "s|__QEMU_ARCH__|${qemu_arch}|g" Dockerfile.${docker_arch}
    sed -i "s|__RCLONE_ARCH__|${rclone_arch}|g" Dockerfile.${docker_arch}
    sed -i "s|__RCLONE_VER__|${rclone_ver}|g" Dockerfile.${docker_arch}
    sed -i "s|__BUILD_DATE__|${build_date}|g" Dockerfile.${docker_arch}
    if [ ${docker_arch} == 'amd64' ]; then
        sed -i "/__CROSS__/d" Dockerfile.${docker_arch}
        cp Dockerfile.${docker_arch} Dockerfile
    else
        sed -i "s/__CROSS__//g" Dockerfile.${docker_arch}
    fi


    # Check for qemu static bins
    if [[ ! -f qemu-${qemu_arch}-static ]]; then
        echo "Downloading the qemu static binaries for ${docker_arch}"
        wget -q -N https://github.com/multiarch/qemu-user-static/releases/download/v4.0.0-4/x86_64_qemu-${qemu_arch}-static.tar.gz
        tar -xvf x86_64_qemu-${qemu_arch}-static.tar.gz
        rm x86_64_qemu-${qemu_arch}-static.tar.gz
    fi

    # Build
    if [ "$EUID" -ne 0 ]; then
        sudo docker build -f Dockerfile.${docker_arch} -t lucashalbert/docker-rclone:${docker_arch}-${rclone_ver} .
        sudo docker push lucashalbert/docker-rclone:${docker_arch}-${rclone_ver}
    else
        docker build -f Dockerfile.${docker_arch} -t lucashalbert/docker-rclone:${docker_arch}-${rclone_var} .
        docker push lucashalbert/docker-rclone:${docker_arch}-${rclone_ver}
    fi
done



# Create latest docker manifest
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create lucashalbert/docker-rclone:latest lucashalbert/docker-rclone:amd64-${rclone_ver} lucashalbert/docker-rclone:arm32v6-${rclone_ver} lucashalbert/docker-rclone:arm64v8-${rclone_ver}

for docker_arch in amd64 arm32v6 arm64v8; do
    case ${docker_arch} in
        amd64   ) image_arch="amd64" ;;
        arm32v6 ) image_arch="arm" ;;
        arm64v8 ) image_arch="arm64" image_variant="armv8" ;;    
    esac

    # Create and annotate arch/ver docker manifest
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create lucashalbert/docker-rclone:${docker_arch}-${rclone_ver} lucashalbert/docker-rclone:${docker_arch}-${rclone_ver}
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest annotate lucashalbert/docker-rclone:${docker_arch}-${rclone_ver} lucashalbert/docker-rclone:${docker_arch}-${rclone_ver} --os linux --arch ${image_arch}

    # Push arch/ver docker manifest
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push lucashalbert/docker-rclone:${docker_arch}-${rclone_ver}

    # Annotate latest docker manifest
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest annotate lucashalbert/docker-rclone:latest lucashalbert/docker-rclone:${docker_arch}-${rclone_ver} --os linux --arch ${image_arch}
done

# Push latest docker manifest
DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push lucashalbert/docker-rclone:latest
