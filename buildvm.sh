#!/bin/bash

DIR=$HOME/ripe-anchor-image
DIR_IMAGE=$DIR/images
IMAGE_PATH="$DIR_IMAGE/centos7-ripe-anchor"
DIC=$HOME/dib/env/bin/disk-image-create

ARCH="amd64"
BASE_ELEMENTS="centos7 bootloader cloud-init-disable-resizefs cloud-init-datasources dracut-regenerate posix openssh-server"
export DIB_BOOTLOADER_DEFAULT_CMDLINE="net.ifnames=0"
export DIB_CLOUD_INIT_DATASOURCES="OpenStack"
export DIB_BLOCK_DEVICE_CONFIG=$(< $DIR/block-device-custom.yaml)

mkdir -p $DIR_IMAGE
$DIC vm $BASE_ELEMENTS -t raw -o $IMAGE_PATH
