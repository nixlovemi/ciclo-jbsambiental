FROM ubuntu:bionic-20200921

# Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# uWSGI and MySQL
RUN apt-get update && \
    apt-get install -y python3-dev mysql-client default-libmysqlclient-dev build-essential \
    uwsgi uwsgi-plugin-python3

# App requirements
COPY requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

EXPOSE 8000

CMD ["/usr/src/frontend/docker-run.sh"]
