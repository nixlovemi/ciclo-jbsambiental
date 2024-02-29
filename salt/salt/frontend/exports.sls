{% from 'docker/exports.sls' import docker_containers_dir with context %}

#------------------------------------------------------------------------------
# set common vars
#------------------------------------------------------------------------------

{% set frontend_id = 10002 %}
{% set frontend_user = 'frontend' %}
{% set frontend_group = 'frontend' %}
{% set frontend_media_dir = docker_containers_dir + '/frontend/media' %}
