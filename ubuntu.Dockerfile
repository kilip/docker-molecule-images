ARG VERSION
FROM ubuntu:${VERSION}

ENV DEBIAN_FRONTEND noninteractive
ENV APT_MIRRORS=archive.ubuntu.com
ENV APT_SECURITY=security.ubuntu.com

COPY bin/initctl_faker.sh initctl_faker

RUN apt-get update \
        && apt-get dist-upgrade -y \
    ;\
    \
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
        wget \
        curl \
    ;\
    \
    sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf \
        && locale-gen en_US.UTF-8 \
    ;\
    if [ "${VERSION}" == "16.04" ]; then \
      apt-get install -y --no-install-recommends \
        python-software-properties \
        python-setuptoools \
      && wget https://bootstrap.pypa.io/get-pip.py \
        && python get-pip.py \
    else \
      pip3 install setuptools \
        && pip3 install ansible \
    ;fi\
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
      && apt-get clean \
    ;\
    \
    rm /etc/apt/sources.list \
      && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic main restricted" >> /etc/apt/sources.list \
      && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates main restricted" >> /etc/apt/sources.list \
      && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic universe" >> /etc/apt/sources.list \
      && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates universe" >> /etc/apt/sources.list \
      && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security main restricted" >> /etc/apt/sources.list \
      && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security universe" >> /etc/apt/sources.list \
    ;

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
