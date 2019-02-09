#!/bin/bash

DIR=$HOME/ripe-anchor-image
DIR_IMAGE=$DIR/images
IMAGE_PATH="$DIR_IMAGE/centos7-ripe-anchor"
DIC=$HOME/dib/env/bin/disk-image-create

ARCH="amd64"
BASE_ELEMENTS="centos7 bootloader cloud-init-datasources openssh-server"
#BASE_ELEMENTS="centos7 bootloader cloud-init-datasources openssh-server local-config devuser"
#BASE_ELEMENTS="centos7 bootloader cloud-init-disable-resizefs cloud-init-datasources dracut-regenerate posix openssh-server"
export DIB_BOOTLOADER_DEFAULT_CMDLINE="net.ifnames=0"
export DIB_CLOUD_INIT_DATASOURCES="OpenStack"
export DIB_BLOCK_DEVICE_CONFIG="file://$DIR/block-device-custom.yaml"
#export DIB_DEV_USER_USERNAME="bob"
#export DIB_DEV_USER_PWDLESS_SUDO="Yes"
#export DIB_DEV_USER_PASSWORD="mypassword"
#export DIB_LOCAL_CONFIG_USERNAME="centos"

mkdir -p $DIR_IMAGE
$DIC vm $BASE_ELEMENTS -t qcow2 -o $IMAGE_PATH
