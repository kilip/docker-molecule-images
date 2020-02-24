ARG VERSION
FROM centos:${VERSION}
LABEL maintainer="Anthonius Munthi"

ARG VERSION

# Install systemd -- See https://hub.docker.com/_/centos/
RUN set -eux; \
      yum -y update; yum clean all; \
      (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
      rm -f /lib/systemd/system/multi-user.target.wants/*;\
      rm -f /etc/systemd/system/*.wants/*;\
      rm -f /lib/systemd/system/local-fs.target.wants/*; \
      rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
      rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
      rm -f /lib/systemd/system/basic.target.wants/*;\
      rm -f /lib/systemd/system/anaconda.target.wants/*; \
    \
      if [ "$VERSION" = 7 ]; then \
        yum makecache fast; \
        yum -y install deltarpm; \
      fi \
      && yum -y install epel-release initscripts \
      && yum -y update \
      && yum -y install \
            sudo \
            which \
            hostname \
            python3 \
            python3-pip \
      && yum clean all \
      && pip3 install ansible \
    ;\
    \
      sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers  \
      && mkdir -p /etc/ansible \
      && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts \
      && mkdir -p /root/.ansible/tmp \
      && touch /root/.ansible/tmp/.keep \
    ;

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]