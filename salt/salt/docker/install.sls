{% from 'docker/exports.sls' import docker_dir, docker_containers_dir with context %}

docker_old_removed:
  pkg.removed:
    - pkgs:
      - docker
      - docker-engine
      - docker.io

docker_deps_installed:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

docker_repository:
  pkgrepo.managed:
    - humanname: Docker Package Repository
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - key_url: https://download.docker.com/linux/ubuntu/gpg

docker_ce_installed:
  pkg.installed:
    - pkgs:
      - docker-ce

{{ docker_dir }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: False

{{ docker_containers_dir }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: False
