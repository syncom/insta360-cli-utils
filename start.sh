#!/bin/sh

docker run --runtime=nvidia --gpus all -v "$(pwd)/datadir":/root/datadir --rm -it ubuntu:insta360
