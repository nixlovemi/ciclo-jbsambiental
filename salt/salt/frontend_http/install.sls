{% from 'docker/exports.sls' import docker_containers_dir with context %}
{% from 'frontend/exports.sls' import frontend_id, frontend_user, frontend_group, frontend_media_dir with context %}

{% set frontend_http_nginx_version = salt['grains.get']('frontend_http:nginx_version') %}
{% set frontend_http_backend = salt['grains.get']('frontend_http:backend') %}

{% set frontend_http_unsecured_host_headers = salt['grains.get']('frontend_http:unsecured_host_headers') %}
{% set frontend_http_secured_host_headers = salt['grains.get']('frontend_http:secured_host_headers') %}
{% set frontend_http_secure_host_header = salt['grains.get']('frontend_http:secure_host_header') %}

{% set frontend_http_static_dir = salt['grains.get']('frontend_http:static_dir') %}

{{ docker_containers_dir }}/frontend_http:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_http/conf:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_http/conf/nginx.conf:
  file.managed:
    - source: salt://frontend_http/files/nginx.conf
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 640
    - makedirs: False

{{ docker_containers_dir }}/frontend_http/conf/frontend_http.conf:
  file.managed:
    - source: salt://frontend_http/files/frontend_http.conf.jinja
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 640
    - makedirs: False
    - template: jinja
    - context:
        backend: {{ frontend_http_backend }}
        unsecured_host_headers: {{ frontend_http_unsecured_host_headers | yaml() }}
        secured_host_headers: {{ frontend_http_secured_host_headers | yaml() }}
        secure_host_header: {{ frontend_http_secure_host_header }}

{{ docker_containers_dir }}/frontend_http/log:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_http/cache:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

{{ docker_containers_dir }}/frontend_http/run:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 750
    - makedirs: False

frontend_http_running:
  docker_container.running:
    - name: frontend_http
    - image: nginx:{{ frontend_http_nginx_version }}
    - restart_policy: unless-stopped
    - user: {{ frontend_id }}:{{ frontend_id }}
    - binds:
      - {{ docker_containers_dir }}/frontend_http/cache:/var/cache/nginx
      - {{ docker_containers_dir }}/frontend_http/conf/nginx.conf:/etc/nginx/nginx.conf
      - {{ docker_containers_dir }}/frontend_http/conf/frontend_http.conf:/etc/nginx/sites-enabled/frontend_http.conf
      - {{ docker_containers_dir }}/frontend_http/log:/var/log/nginx
      - {{ docker_containers_dir }}/frontend_http/run:/var/run
      - {{ docker_containers_dir }}/frontend_certbot_common/www:/var/www/certbot
      - {{ frontend_http_static_dir}}:/var/www/frontend/webapp/static
      - {{ frontend_media_dir}}:/var/www/frontend/webapp/media
    - port_bindings:
      - 80:8080
    - watch:
      - file: {{ docker_containers_dir }}/frontend_http/conf/nginx.conf
      - file: {{ docker_containers_dir }}/frontend_http/conf/frontend_http.conf

frontend_http_logrotate_installed:
  pkg:
    - name: logrotate
    - installed

/etc/logrotate.d/frontend_http:
  file.managed:
    - source: salt://frontend_http/files/nginx.logrotate.jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: False
    - template: jinja
    - context:
        docker_containers_dir: {{ docker_containers_dir }}
