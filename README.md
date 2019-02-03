# ripe-anchor-image

## Requirements
```Shell
sudo apt install python-pip qemu-utils kpartx
sudo -H pip install virtualenv
```
## Install Openstack Diskimage Builder
```Shell
cd ~
mkdir dib
cd dib
virtualenv env
source env/bin/activate
git clone https://git.openstack.org/openstack/diskimage-builder
cd diskimage-builder/
pip install -e .
```
## Build image
```Shell
cd ~
git clone https://github.com/gmasse/ripe-anchor-image.git
cd ripe-anchor-image
sh buildvm.sh
```
## Upload image to glance
```Shell
sudo apt-get install python-openstackclient python-novaclient -y
source openrc.sh
glance image-create --name centos7-ripe-anchor --disk-format qcow2 --container-format bare --file $HOME/ripe-anchor-image/images/centos7-ripe-anchor.qcow2
```
## Launch a VM
```Shell
nova boot --key-name my_ssh --flavor s1-8 --image centos7-ripe-anchor.2 ripe-anchor-gra5-1.2
```
## Tips
### Testing YAML config
```Shell
pip install pyyaml
python -c 'import yaml, sys; print(yaml.safe_load(sys.stdin))' < data.yaml
```
### How to mount a qcow2 disk image containing LVM
https://gist.github.com/pshchelo/6ffabbffaedc46456b39c037d16e1d8c

## References
- https://docs.openstack.org/diskimage-builder/latest/
- http://www.rushiagr.com/blog/2016/01/02/build-vm-image-using-diskimage-builder/
- https://review.openstack.org/#/c/504588/
- https://atlas.ripe.net/docs/anchor-installation-vm/


