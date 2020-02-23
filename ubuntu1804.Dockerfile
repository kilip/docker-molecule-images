FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV APT_MIRRORS=archive.ubuntu.com
ENV APT_SECURITY=security.ubuntu.com

COPY bin/initctl_faker.sh bin/initctl_faker

RUN \
    rm /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic universe" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates universe" >> /etc/apt/sources.list \
        && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security universe" >> /etc/apt/sources.list \
        && apt-get update \
        && apt-get dist-upgrade -y \
    ;\
    apt-get install --fix-missing --no-install-recommends -y \
        python3 \
        python3-pip \
        python3-apt \
    ;\
    \
    apt-get --no-install-recommends install -y \
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
    ;\
    \
    sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf \
        && locale-gen en_US.UTF-8 \
        && pip3 install ansible \
    ;\
    \
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
      && apt-get clean

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
