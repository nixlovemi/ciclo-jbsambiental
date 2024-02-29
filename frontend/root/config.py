# -*- coding: utf-8 -*-

import os

'''
DJANGO_DEBUG = (os.environ['DJANGO_DEBUG'].lower() in ['true', '1'])
DJANGO_SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
DJANGO_ALLOWED_HOSTS = (os.environ['DJANGO_ALLOWED_HOSTS'].split(','))
DJANGO_STATIC_ROOT = os.environ['DJANGO_STATIC_ROOT']
DJANGO_MEDIA_ROOT = os.environ['DJANGO_MEDIA_ROOT']
DJANGO_LOG_FILENAME = os.environ['DJANGO_LOG_FILENAME']
DJANGO_LOG_LEVEL = os.environ['DJANGO_LOG_LEVEL']
DJANGO_LOG_HANDLER = os.environ['DJANGO_LOG_HANDLER']

MYSQL_HOST = os.environ['MYSQL_HOST']
MYSQL_DB = os.environ['MYSQL_DB']
MYSQL_PORT = os.environ['MYSQL_PORT']
MYSQL_USER = os.environ['MYSQL_USER']
MYSQL_PASSWD = os.environ['MYSQL_PASSWD']

EMAIL_HOST = os.environ['EMAIL_HOST']
EMAIL_PORT = int(os.environ['EMAIL_PORT'])
EMAIL_HOST_USER = os.environ['EMAIL_HOST_USER']
EMAIL_HOST_PASSWORD = os.environ['EMAIL_HOST_PASSWORD']
EMAIL_USE_TLS = (os.environ['EMAIL_USE_TLS'].lower() in ['true', '1'])
EMAIL_USE_SSL = (os.environ['EMAIL_USE_SSL'].lower() in ['true', '1'])
'''

# LOCAL ONLY
DJANGO_DEBUG = True
DJANGO_SECRET_KEY = '%*x85+-=b(h7k#7(^=qbm3#xil5__0jfzr@*zjnrdkk*l(32=h'
DJANGO_ALLOWED_HOSTS = ['127.0.0.1']
DJANGO_STATIC_ROOT = './webapp/static/'
DJANGO_MEDIA_ROOT = './webapp/media/'
DJANGO_LOG_FILENAME = './frontend.log'
DJANGO_LOG_LEVEL = 'INFO'
DJANGO_LOG_HANDLER = 'logfile'

MYSQL_HOST = '172.17.0.1'
MYSQL_DB = 'ambiental'
MYSQL_PORT = 3306
MYSQL_USER = 'ambientalappuser'
MYSQL_PASSWD = 'GKSkGDeafn8Q7uAM'

EMAIL_HOST = 'in-v3.mailjet.com'
EMAIL_PORT = 587
EMAIL_HOST_USER = '06a8ecbddc6543afb53542e93387c32c'
EMAIL_HOST_PASSWORD = '56d1e76f4289f56e0e9df5bb9fa87990'
EMAIL_USE_TLS = True
EMAIL_USE_SSL = False
EMAIL_FROM = 'carlos.souza@bffc.com.br'
EMAIL_TO_1 = 'sac@holcasher.com.br'
EMAIL_TO_2 = 'sac@cepera.com.br'

GTM_CODE = 'GTM-54JRFLW'
