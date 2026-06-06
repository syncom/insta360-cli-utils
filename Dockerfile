# From repo root directory, build Docker image with command:
#   docker build --tag ubuntu:insta360 [--build-arg="MEDIASDK_UBUNTU_DEB=<deb_file>"] .
# Need exiftool 12.40 or above
FROM ubuntu:24.04

ARG MEDIASDK_UBUNTU_DEB=libMediaSDK-dev_2.0-6_amd64_ubuntu18.04.deb
ENV PATH="${PATH}:/root/scripts"

WORKDIR /root
COPY ${MEDIASDK_UBUNTU_DEB} .
RUN apt update && \
    apt install exiftool ffmpeg bc -y
RUN apt install "./${MEDIASDK_UBUNTU_DEB}" -y

COPY scripts scripts
