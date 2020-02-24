ARG VERSION
FROM centos:${VERSION}
LABEL maintainer="Anthonius Munthi"

ARG VERSION

ENV container docker

# Install systemd -- See https://hub.docker.com/_/centos/
RUN \
      (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
      systemd-tmpfiles-setup.service ] || rm -f $i; done); \
      rm -f /lib/systemd/system/multi-user.target.wants/*;\
      rm -f /etc/systemd/system/*.wants/*;\
      rm -f /lib/systemd/system/local-fs.target.wants/*; \
      rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
      rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
      rm -f /lib/systemd/system/basic.target.wants/*;\
      rm -f /lib/systemd/system/anaconda.target.wants/*;\
    \
      set -eux; \
      yum -y install \
          deltarpm \
          epel-release \
          initscripts \
          which \
          hostname \
      && yum -y update; \
      if [ $(command -v dnf) ]; then \
        dnf makecache \
        && dnf --assumeyes install \
            bash \
            iproute \
            sudo \
            python3 \
            python3-pip \
            python3-devel \
            python3*-dnf \
         && dnf clean all; \
         ln -s /usr/bin/python3 /usr/bin/python; \
         ln -s /usr/bin/pip3 /usr/bin/pip; \
      else \
        yum makecache fast \
        && yum install -y \
          python-pip \
          python3 \
          python3-pip \
          sudo \
          yum-plugin-ovl \
          bash \
          iproute \
        && yum clean all; \
      fi \
    ;\
      sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers \
      && sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf \
    ;
    # END RUN

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/lib/systemd/systemd"]
