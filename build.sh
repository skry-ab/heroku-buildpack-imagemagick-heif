#!/bin/bash

# set -x
set -e

VERSION=${1:-22}

docker build --platform linux/amd64 -t heroku-buildpack-imagemagick-webp -f "Dockerfile.$VERSION" .
mkdir -p build

docker run --platform linux/amd64 --rm -t -v $PWD/build:/data heroku-buildpack-imagemagick-webp sh -c 'cp -f /usr/src/imagemagick/build/*.tar.gz /data/'
