ARG VERSION
FROM debian:${VERSION}
LABEL maintainer="Anthonius Munthi"

ARG VERSION
ENV DEBIAN_FRONTEND noninteractive
ENV USE_MIRROR no
ENV COUNTRY none

COPY bin/initctl_faker.sh initctl_faker
COPY bin/debian-entrypoint.sh /bin/entrypoint

# Install dependencies.
RUN set -eux; \
    \
      apt-get update \
      && apt-get install -y --no-install-recommends \
          python3 \
          python3-apt \
          python3-dev \
          python3-setuptools \
          python3-wheel \
          python3-pip \
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
          apt-transport-https \
          netselect-apt \
    ;\
    \
        update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
        && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
        && update-alternatives --config python \
        && update-alternatives --config pip \
    ;\
      chmod +x initctl_faker \
      && rm -fr /sbin/initctl \
      && ln -s /initctl_faker /sbin/initctl \
    ;\
    \
      rm -f /lib/systemd/system/multi-user.target.wants/getty.target \
      && apt-get autoremove --purge \
      && apt-get clean \
      && mkdir -p /root/.ansible/tmp \
      && chmod +x /bin/entrypoint \
    ;

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
ENTRYPOINT [ "/bin/entrypoint" ]
CMD ["/lib/systemd/systemd"]
