#!/bin/sh

if [ "$USE_MIRROR" = 'yes' ]; then
  netselect-apt -c ${COUNTRY} -t 15 -a amd64 -n testing;
  mv /etc/apt/sources.list /etc/apt/sources.list_backup;
  mv sources.list /etc/apt/sources.list;
fi

exec /lib/systemd/systemd
