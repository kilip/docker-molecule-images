#!/bin/sh

set -eux

install_xenial(){
  apt-get install -y --no-install-recommends \
    python-software-properties \
    python-setuptoools;

  wget https://bootstrap.pypa.io/get-pip.py \
    python get-pip.py;
}

install_bionic(){
  apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
      python3-wheel \
      python3-setuptools;

  pip3 install ansible;
}

if [ "$VERSION" = "16.04" ]; then
  install_xenial
else
  install_bionic
fi
