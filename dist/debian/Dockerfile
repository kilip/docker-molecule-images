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
      if [ "$VERSION" = '9' ]; then \
        apt-get install -y --no-install-recommends \
          python \
          python-apt \
          python-dev \
          python-setuptools\
          python-wheel \
          python-pip \
        ;\
      else \
        apt-get install -y --no-install-recommends \
          python3 \
          python3-apt \
          python3-dev \
          python3-setuptools \
          python3-wheel \
          python3-pip \
        ;\
        update-alternatives --install /usr/bin/python python /usr/bin/python3 1; \
        update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1; \
        update-alternatives --config python; \
        update-alternatives --config pip; \
      fi \
    ;\
    \
      chmod +x initctl_faker \
      && rm -fr /sbin/initctl \
      && ln -s /initctl_faker /sbin/initctl \
    ;\
    \
      rm -f /lib/systemd/system/multi-user.target.wants/getty.target \
      && apt-get autoremove --purge \
      && apt-get clean \
    ;

VOLUME ["/sys/fs/cgroup"]

CMD ["/lib/systemd/systemd"]