{% from 'docker/exports.sls' import docker_containers_dir with context %}
{% from 'frontend/exports.sls' import frontend_id, frontend_user, frontend_group, frontend_media_dir with context %}

{% set frontend_image = salt['grains.get']('frontend:image') %}
{% set frontend_environment = salt['grains.get']('frontend:environment') %}
{% set frontend_port_bindings = salt['grains.get']('frontend:port_bindings') %}
{% set frontend_source_dir = salt['grains.get']('frontend:source_dir') %}

frontend_group:
  group.present:
    - name: {{ frontend_group }}
    - gid: {{ frontend_id }}

frontend_user:
  user.present:
    - name: {{ frontend_user }}
    - uid: {{ frontend_id }}
    - shell: /bin/bash
    - home: {{ docker_containers_dir }}/frontend
    - createhome: True
    - groups:
      - {{ frontend_group }}

{{ docker_containers_dir }}/frontend:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 755
    - makedirs: False

{{ docker_containers_dir }}/frontend/log:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0755
    - makedirs: False

{{ docker_containers_dir }}/frontend/log/uwsgi:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0755
    - makedirs: False

{{ docker_containers_dir }}/frontend/log/frontend:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0755
    - makedirs: False

{{ frontend_media_dir }}:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0755
    - makedirs: False

/var/lib/frontend/docker:
  file.recurse:
    - source: salt://frontend/docker
    - include_empty: True
    - user: root
    - group: root
    - makedirs: True

frontend_image_build:
  cmd.run:
    - name: cd /var/lib/frontend/docker && docker build --tag "{{ frontend_image }}" ./
    - unless: docker image inspect "{{ frontend_image }}"

frontend_running:
  docker_container.running:
    - name: frontend
    - image: {{ frontend_image }}
    - restart_policy: unless-stopped
    - user: {{ frontend_id }}:{{ frontend_id }}
    - environment: {{ frontend_environment | yaml() }}
    - binds:
      - {{ frontend_source_dir }}:/usr/src/frontend:ro
      - {{ frontend_media_dir }}:/var/www/frontend/webapp/media:rw
      - {{ docker_containers_dir }}/frontend/log/uwsgi:/var/log/uwsgi:rw
      - {{ docker_containers_dir }}/frontend/log/frontend:/var/log/frontend:rw
    - port_bindings: {{ frontend_port_bindings | yaml() }}
