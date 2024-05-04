# Automate Insta360 360-degree video processing

This repository contains the utility and instructions to process Insta360
360-degree videos (with extension `.insv`) from the command line,
without using the [Insta360
Studio](https://www.insta360.com/download/insta360-x3) (Insta360's desktop
editing software).

## Prerequisites

- A machine that runs Docker
- Enough free space on your local file system to store original and processed
  video files
- [Fill out the application](https://www.insta360.com/sdk/home), get approved,
  and download the Insta360 media SDK for Linux
  - The media SDK I have access to is `LinuxSDK20231211.zip`. It contains a
    pre-built package `libMediaSDK-dev_2.0-0_amd64_ubuntu18.04.deb` for Ubuntu
    18.04, which is the only file I need from the zip

## My workflow for converting and joining 360-degree videos

1. Clone this repo.

   ```bash
   git clone https://github.com/syncom/insta360-cli-utils.git
   ```

2. Extract the aforementioned `.deb` file from the media SDK zip, and put it
   under the directory root of the just cloned repository.

3. Build the Docker container image in which the SDK is installed.

   ```bash
   # Under repo's directory root
   docker build --tag ubuntu:insta360 .
   ```

4. Run the container, mounting host directory `datadir/` to the container's path
   `/root/`, for host-container data sharing.

   ```bash
   docker run -v "$(pwd)/datadir":/root -it ubuntu:insta360
   ```
