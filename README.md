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
export OS_REGION_NAME="GRA5"
glance image-create --name centos7-ripe-anchor --disk-format qcow2 --container-format bare --architecture x86_64 --os-distro centos --os-version 7.6 --min-ram 2048 --min-disk 50 --file $HOME/ripe-anchor-image/images/centos7-ripe-anchor.qcow2
```
## Launch a VM
```Shell
nova boot --key-name my_ssh --flavor b2-7 --image centos7-ripe-anchor ripe-anchor-gra5-1 --user-data cloud-config
nova show ripe-anchor-gra5-1
```
...
```Shell
nova delete ripe-anchor-gra5-1
```
## Tips
### [OVH] Configure IPv6
Edit `/etc/sysconfig/network-scripts/ifcfg-eth0` and add:
```
IPV6INIT=yes
IPV6ADDR=2001:41d0:XXXX:XXXX::XXXX/128
IPV6_DEFAULTGW=2001:41d0:XXXX:XXXX::1
```
Create `/etc/sysconfig/network-scripts/route6-eth0`:
```
2001:41d0:XXXX:XXXX::1 dev eth0
default via 2001:41d0:XXXX:XXXX::1
```
Finally, we avoid cloud-init to overwrite network configuration files.
Edit `/etc/cloud/cloud.cfg` and add:
```
network:
  config: disabled
```
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


