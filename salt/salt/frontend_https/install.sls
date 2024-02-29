{% from 'docker/exports.sls' import docker_containers_dir with context %}
{% from 'frontend/exports.sls' import frontend_id, frontend_user, frontend_group, frontend_media_dir with context %}

{% set frontend_https_nginx_version = salt['grains.get']('frontend_https:nginx_version') %}
{% set frontend_https_backend = salt['grains.get']('frontend_https:backend') %}
{% set frontend_https_secure_host_headers = salt['grains.get']('frontend_https:secure_host_headers') %}
{% set frontend_https_static_dir = salt['grains.get']('frontend_https:static_dir') %}
{% set frontend_https_enable_hsts = salt['grains.get']('frontend_https:enable_hsts', False) %}

{{ docker_containers_dir }}/frontend_https:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_https/conf:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_https/conf/nginx.conf:
  file.managed:
    - source: salt://frontend_https/files/nginx.conf
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 640
    - makedirs: False

{{ docker_containers_dir }}/frontend_https/conf/frontend_https.conf:
  file.managed:
    - source: salt://frontend_https/files/frontend_https.conf.jinja
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 640
    - makedirs: False
    - template: jinja
    - context:
        backend: {{ frontend_https_backend }}
        secure_host_headers: {{ frontend_https_secure_host_headers | yaml() }}
        enable_hsts: {{ frontend_https_enable_hsts }}

{{ docker_containers_dir }}/frontend_https/log:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_https/cache:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_https/run:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

frontend_https_running:
  docker_container.running:
    - name: frontend_https
    - image: nginx:{{ frontend_https_nginx_version }}
    - restart_policy: unless-stopped
    - user: {{ frontend_id }}:{{ frontend_id }}
    - binds:
      - {{ docker_containers_dir }}/frontend_https/cache:/var/cache/nginx
      - {{ docker_containers_dir }}/frontend_https/conf/nginx.conf:/etc/nginx/nginx.conf
      - {{ docker_containers_dir }}/frontend_https/conf/frontend_https.conf:/etc/nginx/sites-enabled/frontend_https.conf
      - {{ docker_containers_dir }}/frontend_https/log:/var/log/nginx
      - {{ docker_containers_dir }}/frontend_https/run:/var/run
      - {{ docker_containers_dir }}/frontend_certbot_common/www:/var/www/certbot
      - {{ docker_containers_dir }}/frontend_certbot_common/conf:/etc/letsencrypt
      - {{ frontend_https_static_dir }}:/var/www/frontend/webapp/static
      - {{ frontend_media_dir }}:/var/www/frontend/webapp/media
    - port_bindings:
      - 443:8443
    - watch:
      - file: {{ docker_containers_dir }}/frontend_https/conf/nginx.conf
      - file: {{ docker_containers_dir }}/frontend_https/conf/frontend_https.conf

frontend_https_logrotate_installed:
  pkg:
    - name: logrotate
    - installed

/etc/logrotate.d/frontend_https:
  file.managed:
    - source: salt://frontend_https/files/nginx.logrotate.jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: False
    - template: jinja
    - context:
        docker_containers_dir: {{ docker_containers_dir }}

frontend_https_reload_cron:
  cron.present:
    - identifier: frontend_https_reload_cron
    - name: docker exec -t frontend_https nginx -s reload
    - user: root
    - minute: random
    - hour: 2
