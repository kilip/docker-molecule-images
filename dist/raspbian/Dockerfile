ARG VERSION

FROM balenalib/raspberrypi3-debian:${VERSION}

RUN [ "cross-build-start" ]

ARG VERSION

ENV container docker
ENV DEBIAN_FRONTEND noninteractive
ENV USE_MIRROR no

COPY bin/initctl_faker.sh initctl_faker
COPY bin/ubuntu-entrypoint.sh /bin/entrypoint.sh

RUN \
      set -ex; \
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
          python3 \
          python3-pip \
          python3-wheel \
          python3-setuptools\
      ;\
    \
      sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf; \
      locale-gen en_US.UTF-8 \
    ;\
    \
      if [ "$VERSION" = "16.04" ]; then \
        apt-get install -y --no-install-recommends \
          gnupg-agent; \
      else \
        apt-get install -y --no-install-recommends \
            gpg-agent; \
      fi \
    ;\
    \
        update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
        && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
        && update-alternatives --config python \
        && update-alternatives --config pip \
        && pip install --upgrade pip \
    ;\
      chmod +x initctl_faker \
      && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl \
      && chmod +x /bin/entrypoint.sh \
    ;\
    \
      rm -f /lib/systemd/system/systemd*udev* \
      && rm -f /lib/systemd/system/getty.target \
    ;\
      apt-get autoremove --purge \
      && apt-get clean \
      && mkdir -p /root/.ansible/tmp \
    ;


VOLUME [ "/sys/fs/cgroup", "/tmp", "/run"]

ENTRYPOINT [ "/bin/entrypoint.sh" ]

RUN [ "cross-build-end" ]
