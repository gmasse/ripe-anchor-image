#!/bin/bash

DIR=$HOME/ripe-anchor-image
DIR_IMAGE=$DIR/images
IMAGE_PATH="$DIR_IMAGE/centos7-ripe-anchor"
DIC=$HOME/dib/env/bin/disk-image-create

ARCH="amd64"
#BASE_ELEMENTS="centos7 bootloader cloud-init-datasources c7-cloud-init-fix dracut-regenerate openssh-server devuser"
BASE_ELEMENTS="centos7 bootloader cloud-init-datasources c7-cloud-init-fix dracut-regenerate openssh-server"
export ELEMENTS_PATH=$DIR/elements
#export DIB_DEV_USER_USERNAME="bob"
#export DIB_DEV_USER_PWDLESS_SUDO="Yes"
#export DIB_DEV_USER_PASSWORD="mypassword"
export DIB_BOOTLOADER_DEFAULT_CMDLINE="net.ifnames=0"
export DIB_CLOUD_INIT_DATASOURCES="Ec2, ConfigDrive, OpenStack"
export DIB_BLOCK_DEVICE_CONFIG="file://$DIR/block-device-custom.yaml"

mkdir -p $DIR_IMAGE
$DIC -x -x -a $ARCH -t qcow2 -o $IMAGE_PATH vm $BASE_ELEMENTS | tee $DIR/dib.log
