# ripe-anchor-image

## Requirements
- python
- pip
- virtualenv

## Openstack Diskimage Builder
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
