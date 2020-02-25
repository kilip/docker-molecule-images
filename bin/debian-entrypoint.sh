#!/bin/sh

if [ "$USE_MIRROR" = 'yes' ]; then
  netselect-apt -c ${COUNTRY} -t 5 -a amd64 -n testing -o /tmp/sources.list;
  mv /etc/apt/sources.list /etc/apt/sources.list_backup;
  mv /tmp/sources.list /etc/apt/sources.list;
fi

exec /lib/systemd/systemd
