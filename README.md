# ripe-anchor-image

## Requirements
python
pip
virtualenv

## Openstack Diskimage Builder
cd ~
mkdir dib
cd dib
virtualenv env
source env/bin/activate
git clone https://git.openstack.org/openstack/diskimage-builder
cd diskimage-builder/
pip install -e .
