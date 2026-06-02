# For exiftool 12.40
FROM ubuntu:22.04

ARG MEDIASDK_UBUNTU_DEB=libMediaSDK-dev-3.1.1.0-20250922_191110-amd64.deb
ENV PATH="${PATH}:/root/scripts"

RUN apt update && \
    apt install -y software-properties-common && \
    apt install -y curl git build-essential libjpeg-dev libtiff-dev ffmpeg exiftool bc libvulkan1 libvulkan-dev vulkan-tools libglfw3-dev libdc1394-dev mesa-utils && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY ${MEDIASDK_UBUNTU_DEB} .
RUN dpkg -i ${MEDIASDK_UBUNTU_DEB}
COPY scripts scripts
