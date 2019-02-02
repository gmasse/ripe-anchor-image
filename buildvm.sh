#!/bin/bash

DIR=$HOME/dib
DIC=$DIR/env/bin/disk-image-create
IMAGE_PATH="/data/images/centos7-ripe-anchor"

ARCH="amd64"
BASE_ELEMENTS="centos7 bootloader cloud-init-datasources openssh-server "
export DIB_BOOTLOADER_DEFAULT_CMDLINE="net.ifnames=0"
export DIB_CLOUD_INIT_DATASOURCES="OpenStack"
export DIB_BLOCK_DEVICE_CONFIG=$(< $DIR/block-device-custom.yaml)

$DIC vm $BASE_ELEMENTS -t qcow2 -o $IMAGE_PATH
