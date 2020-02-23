ARG VERSION

FROM ubuntu:${VERSION}

ENV DEBIAN_FRONTEND=noninteractive

COPY bin/initctl_faker.sh initctl_faker
COPY bin/ubuntu-install.sh ubuntu-install

RUN set -ex; \
    export VERSION=${VERSION}
    apt-get update \
    && apt-get install --fix-missing --no-install-recommends -y \
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
    ;\
    \
    sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf \
        && locale-gen en_US.UTF-8 \
    ;\
      chmod +x ubuntu-install \
      && /ubuntu-install \
    ;\
    chmod +x initctl_faker \
      && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl \
      && mkdir -p /etc/ansible \
      && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    ;\
    \
    rm -f /lib/systemd/system/systemd*udev* \
      && rm -f /lib/systemd/system/getty.target \
    ;\
    apt-get autoremove --purge \
      && apt-get clean \
    ;


VOLUME [ "/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
