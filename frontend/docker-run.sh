#!/bin/sh

export PYTHONPATH=/usr/local/lib/python38.zip
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.8
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.8/lib-dynload
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.8/site-packages

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/


cd /usr/src/frontend

python3 manage.py migrate

uwsgi --plugins http,python3,logfile \
  --http :8000 \
  --module root.wsgi \
  --processes 2 \
  --threads 2 \
  --logger file:logfile=/var/log/uwsgi/uwsgi.log,maxsize=1000000
