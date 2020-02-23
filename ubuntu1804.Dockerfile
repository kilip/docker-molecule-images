FROM ubuntu:18.04-latest

ENV DEBIAN_FRONTEND noninteractive
ENV APT_MIRRORS=archive.ubuntu.com
ENV APT_SECURITY=security.ubuntu.com

RUN set -eux; \
    rm /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic universe" >> /etc/apt/sources.list \
        && echo "deb http://${APT_MIRRORS}/ubuntu/ bionic-updates universe" >> /etc/apt/sources.list \
        && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security main restricted" >> /etc/apt/sources.list \
        && echo "deb http://${APT_SECURITY}/ubuntu/ bionic-security universe" >> /etc/apt/sources.list \
        && cp -v ./deb/*.* /var/cache/apt/archives \
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
    ;\
    \
    sed -i "s/^\($ModLoad imklog\)/#\1/" /etc/rsyslog.conf \
        && locale-gen en_US.UTF-8 \
        && pip3 install ansible

RUN apt-get autoremove --purge \
    && apt-get clean

