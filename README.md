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

## References
- https://docs.openstack.org/diskimage-builder/latest/
- http://www.rushiagr.com/blog/2016/01/02/build-vm-image-using-diskimage-builder/
