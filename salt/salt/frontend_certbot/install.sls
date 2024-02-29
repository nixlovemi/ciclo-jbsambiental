{% from 'docker/exports.sls' import docker_containers_dir with context %}
{% from 'frontend/exports.sls' import frontend_id, frontend_user, frontend_group with context %}

{% set frontend_certbot_image = salt['grains.get']('frontend_certbot:image') %}
{% set frontend_certbot_secure_host_headers = salt['grains.get']('frontend_certbot:secure_host_headers') %}
{% set frontend_certbot_email = salt['grains.get']('frontend_certbot:email') %}

{{ docker_containers_dir }}/frontend_certbot:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot/docker:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot/docker/docker-entrypoint.sh:
  file.managed:
    - source: salt://frontend_certbot/files/docker-entrypoint.sh.jinja
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False
    - template: jinja
    - context:
        secure_host_headers: {{ frontend_certbot_secure_host_headers | yaml() }}
        email: {{ frontend_certbot_email }}

{{ docker_containers_dir }}/frontend_certbot/lib:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot/log:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

frontend_certbot_running:
  docker_container.running:
    - name: frontend_certbot
    - image: {{ frontend_certbot_image }}
    - entrypoint: "/docker/docker-entrypoint.sh"
    - restart_policy: unless-stopped
    - user: {{ frontend_id }}:{{ frontend_id }}
    - binds:
      - {{ docker_containers_dir }}/frontend_certbot/docker:/docker
      - {{ docker_containers_dir }}/frontend_certbot/lib:/var/lib/letsencrypt
      - {{ docker_containers_dir }}/frontend_certbot/log:/var/log/letsencrypt
      - {{ docker_containers_dir }}/frontend_certbot_common/www:/var/www/certbot
      - {{ docker_containers_dir }}/frontend_certbot_common/conf:/etc/letsencrypt
    - watch:
      - file: {{ docker_containers_dir }}/frontend_certbot/docker/docker-entrypoint.sh
