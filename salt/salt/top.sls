base:
  '*':
    - common

  'roles:backend':
    - match: grain
    - backend

  'roles:db':
    - match: grain
    - db

  'roles:frontend':
    - match: grain
    - frontend

  'roles:frontend_certbot':
    - match: grain
    - frontend_certbot

  'roles:frontend_http':
    - match: grain
    - frontend_http

  'roles:frontend_https':
    - match: grain
    - frontend_https

  'roles:salt_master':
    - match: grain
    - salt_master
