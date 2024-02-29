{% from 'common/exports.sls' import common_storage_dir with context %}

#------------------------------------------------------------------------------
# set docker vars
#------------------------------------------------------------------------------
{% set docker_dir = common_storage_dir + '/docker' %}
{% set docker_containers_dir = docker_dir + '/containers' %}
