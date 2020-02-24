ARG VERSION

FROM ubuntu:${VERSION}

ARG VERSION
ARG TAG

ENV DEBIAN_FRONTEND=noninteractive
ENV USE_MIRROR=no

COPY bin/initctl_faker.sh initctl_faker
COPY bin/mirror.sh /bin/mirror.sh

RUN set -ex; \
    \
      apt-get update; \
      apt-get install --fix-missing --no-install-recommends -y \
          libterm-readline-gnu-perl \
          apt-transport-https \
          apt-utils \
          sudo \
          bash \
          ca-certificates \
          iproute2 \
          software-properties-common \
          dirmngr \
          rsyslog \
          systemd \
          systemd-cron \
          sudo \
          iproute2 \
          locales \
          wget \
          curl \
          gpg-agent \
      ;\
    \
      sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf; \
      locale-gen en_US.UTF-8 \
    ;\
    \
      if [ "$VERSION" = "16.04" ]; then \
        apt-get install -y --no-install-recommends \
          python-software-properties \
          python-setuptools;\
        wget https://bootstrap.pypa.io/get-pip.py; \
        python get-pip.py; \
        pip install ansible; \
      else \
        apt-get install -y --no-install-recommends \
            python3 \
            python3-pip \
            python3-wheel \
            python3-setuptools;\
        pip3 install ansible; \
      fi \
    ;\
      chmod +x initctl_faker \
        && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl \
        && mkdir -p /etc/ansible \
        && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
      chmod +x /bin/mirror.sh \
    ;\
    \
    rm -f /lib/systemd/system/systemd*udev* \
      && rm -f /lib/systemd/system/getty.target \
    ;\
      apt-get autoremove --purge \
      && apt-get clean \
      && mkdir -p /root/.ansible/tmp \
      && touch /root/.ansible/tmp/.keep \
    ;


VOLUME [ "/sys/fs/cgroup", "/tmp", "/run"]

CMD ["/lib/systemd/systemd"]
