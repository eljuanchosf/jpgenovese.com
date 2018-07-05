#! /bin/bash

set -e

USERNAME=juanpgenovese
IMAGE_NAME=site
TAG=1.0

docker build ../ -f Dockerfile -t $USERNAME/$IMAGE_NAME:$TAG
docker push $USERNAME/$IMAGE_NAME:$TAG