# Insta360 360-degree video processing in command-line

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

   Copy/move `.insv` files to "$(pwd)/datadir" on host, for processing in the
   container.

5. Inside the Docker container, in shell prompt

   ```bash
   MERGED_VIDEO="merged.mp4"
   MERGED_VIDEO_360="merged360.mp4"
   # Convert to MP4, for 4K and lower resolution videos
   for i in *.insv; do \
     MediaSDKTest -inputs "$i" -output "${i}.mp4" \
     -enable_directionlock -enable_flowstate -enable_denoise
   done
   # Join MP4 files into one (assuming file names are sorted in time order)
   ls *.mp4 > list.txt
   sed -i.bak 's/^/file /g' list.txt
   ffmpeg -safe 0 -f concat -i list.txt -vcodec copy -acodec copy "$MERGED_VIDEO"
   # Inject metadata (RDF/XML GSpherical tags)
   exiftool -XMP-GSpherical:Spherical="true" \
    -XMP-GSpherical:Stitched="true" \
    -XMP-GSpherical:ProjectionType="equirectangular" \
    -XMP-GSpherical:StereoMode="mono" "$MERGED_VIDEO" \
    -o "$MERGED_VIDEO_360"
   ```

   "$MERGED_VIDEO_360" is the merged 360-degree video that can be viewed in [VLC
   media player](https://www.videolan.org/) or uploaded to YouTube as a 360
   video.
