FROM ubuntu:18.04

ARG MEDIASDK_UBUNTU_DEB=libMediaSDK-dev_2.0-0_amd64_ubuntu18.04.deb

RUN apt update && apt install software-properties-common -y && \
 add-apt-repository 'deb http://security.ubuntu.com/ubuntu xenial-security main' && \
 apt update && \
 apt install curl git build-essential libjpeg-dev libtiff-dev libjasper-dev -y
WORKDIR /root
COPY ${MEDIASDK_UBUNTU_DEB} .
RUN dpkg -i ${MEDIASDK_UBUNTU_DEB}