{% from 'docker/exports.sls' import docker_containers_dir with context %}

{% set db_id = 10001 %}
{% set db_mysql_version = salt['grains.get']('db:mysql_version') %}
{% set db_mysql_root_password = salt['grains.get']('db:mysql_root_password') %}
{% set db_mysql_database = salt['grains.get']('db:mysql_database') %}
{% set db_mysql_user = salt['grains.get']('db:mysql_user') %}
{% set db_mysql_password = salt['grains.get']('db:mysql_password') %}

db_group:
  group.present:
    - name: db
    - gid: {{ db_id }}

db_user:
  user.present:
    - name: db
    - uid: {{ db_id }}
    - shell: /bin/bash
    - home: {{ docker_containers_dir }}/db
    - createhome: True
    - groups:
      - db

{{ docker_containers_dir }}/db:
  file.directory:
    - user: db
    - group: db
    - mode: 755
    - makedirs: False

{{ docker_containers_dir }}/db/data:
  file.directory:
    - user: db
    - group: db
    - mode: 755
    - makedirs: False

db_running:
  docker_container.running:
    - name: db
    - image: mysql:{{ db_mysql_version }}
    - restart_policy: unless-stopped
    - user: {{ db_id }}:{{ db_id }}
    - environment:
        - MYSQL_ROOT_PASSWORD: {{ db_mysql_root_password }}
        - MYSQL_DATABASE: {{ db_mysql_database }}
        - MYSQL_USER: {{ db_mysql_user }}
        - MYSQL_PASSWORD: {{ db_mysql_password }}
    - binds:
      - {{ docker_containers_dir }}/db/data:/var/lib/mysql
    - port_bindings:
          - 3306:3306
