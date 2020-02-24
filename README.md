Molecule Docker Images
====

This repository contains a docker container to be used in molecule,
which have a `systemd` enabled in the container.

[![Build Status](https://travis-ci.com/kilip/docker-molecule-images.svg?branch=master)](https://travis-ci.com/kilip/docker-molecule-images)

Available images
| Distro | Version | Python |
| ------ | ------- | ------ |
| Ubuntu | 20.04 (Focal)  | 3.7 |
| Ubuntu | 18.04 (Bionic) | 3.6 |
| Ubuntu | 16.04 (Xenial) | 2.7 |
| Debian | 10 (Buster)    | 3.6 |
| Debian | 9 (Stretch)    | 2.7 |
| CentOS | 8              | 3.6 |
| CentOS | 7              | 2.7 |

Molecule sample use
====

```yaml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: instance
    image: kilip/molecule-ubuntu:18.04
    pre_build_image: true
provisioner:
  name: ansible
verifier:
  name: ansible
```
