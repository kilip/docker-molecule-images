ARG VERSION
FROM debian:${VERSION}
LABEL maintainer="Anthonius Munthi"

ARG VERSION
ENV DEBIAN_FRONTEND noninteractive

COPY bin/initctl_faker.sh initctl_faker

# Install dependencies.
RUN set -eux; \
    \
      apt-get update \
      && apt-get install -y --no-install-recommends \
          software-properties-common \
          sudo \
          systemd \
          systemd-sysv \
          build-essential \
          wget \
          libffi-dev \
          libssl-dev \
          ca-certificates \
          gpg-agent \
          gpg \
          dirmngr \
    ;\
    \
      wget https://bootstrap.pypa.io/get-pip.py; \
      if [ "$VERSION" = '9' ]; then \
        cat /etc/apt/sources.list; \
        apt-get install -y --no-install-recommends \
          python-apt \
          python-dev \
          python-setuptools\
          python-wheel \
        ;\
        python get-pip.py \
          && pip install ansible cryptography;\
      else \
        apt-get install -y --no-install-recommends \
          python3-apt \
          python3-dev \
          python3-setuptools \
          python3-wheel \
          python3-pip \
        ;\
        pip3 install ansible cryptography; \
      fi \
    ;\
    \
      chmod +x initctl_faker \
      && rm -fr /sbin/initctl \
      && ln -s /initctl_faker /sbin/initctl \
    ;\
    \
      mkdir -p /etc/ansible \
      && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    ;\
    \
      rm -f /lib/systemd/system/multi-user.target.wants/getty.target \
      && apt-get autoremove --purge \
      && apt-get clean \
      && mkdir -p /root/.ansible/tmp \
      && touch /root/.ansible/tmp/.keep \
    ;

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]
