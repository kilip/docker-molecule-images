#!/bin/sh

if [ ${USE_MIRROR} = 'yes']; then
  MIRROR=`wget -qO - http://mirrors.ubuntu.com/mirrors.txt | head -1 | sed 's#http://##' | sed 's#/ubuntu/##g' `;
  sed -i "s/archive.ubuntu.com/${MIRROR}/g" /etc/apt/sources.list;
  sed -i "s/security.ubuntu.com/${MIRROR}/g" /etc/apt/sources.list;
fi
