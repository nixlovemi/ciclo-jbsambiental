{% from 'common/exports.sls' import common_storage_dir with context %}

{{ common_storage_dir }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
