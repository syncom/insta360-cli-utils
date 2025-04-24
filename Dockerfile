# For exiftool 12.40
FROM ubuntu:22.04

ARG MEDIASDK_UBUNTU_DEB=libMediaSDK-dev_2.0-6_amd64_ubuntu18.04.deb
ENV PATH="${PATH}:/root/scripts"

RUN apt update && apt install software-properties-common -y && \
 apt install curl git build-essential libjpeg-dev libtiff-dev ffmpeg exiftool bc -y
WORKDIR /root
COPY ${MEDIASDK_UBUNTU_DEB} .
RUN dpkg -i ${MEDIASDK_UBUNTU_DEB}
COPY scripts scripts