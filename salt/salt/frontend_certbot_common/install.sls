{% from 'docker/exports.sls' import docker_containers_dir with context %}
{% from 'frontend/exports.sls' import frontend_id, frontend_user, frontend_group with context %}

{{ docker_containers_dir }}/frontend_certbot_common:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot_common/conf:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot_common/www:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot_common/www/.well-known:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False

{{ docker_containers_dir }}/frontend_certbot_common/www/.well-known/acme-challenge:
  file.directory:
    - user: {{ frontend_user }}
    - group: {{ frontend_group }}
    - mode: 0750
    - makedirs: False
