# Build a RIPE Anchor Openstack Image

We are using Openstack Diskimage-builder to generate a VM with the required partitionning layout.

The process is fully automatized, reproductible and adaptable.
The partitionning layout is defined in the YAML file: [block-device-custom.yaml](block-device-custom.yaml).


## Requirements
```Shell
sudo apt install python-pip qemu-utils kpartx
sudo -H pip install virtualenv
```
## Install Openstack Diskimage-builder
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
glance --os-region-name GRA5 image-create --name centos7-ripe-anchor --disk-format qcow2 --container-format bare --architecture x86_64 --os-distro centos --os-version 7.3 --min-ram 2048 --min-disk 50 --file $HOME/ripe-anchor-image/images/centos7-ripe-anchor.qcow2
```
## Launch a VM
```Shell
nova boot --key-name my_ssh --flavor s1-8 --image centos7-ripe-anchor.2 ripe-anchor-gra5-1.2
nova show ripe-anchor-gra5-1.2
```
...
```Shell
nova delete ripe-anchor-gra5-1.2
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


