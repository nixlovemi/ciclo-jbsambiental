from django.core.mail import send_mail
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

import json
import logging

from webapp import config, models


def build_context(**kwargs):
    base_context = {
        'config': config,
    }
    return {**base_context, **kwargs}


def index(request):
    context = build_context()
    return HttpResponse(render(request, 'home.html', context))


def quem_somos(request):
    context = build_context()
    return HttpResponse(render(request, 'quem-somos.html', context))


def servicos(request):
    context = build_context()
    return HttpResponse(render(request, 'servicos.html', context))


def produtos(request):
    context = build_context()
    return HttpResponse(render(request, 'produtos.html', context))


def contato(request):
    context = build_context()
    return HttpResponse(render(request, 'contato.html', context))


def privacidade(request):
    context = build_context()
    return HttpResponse(render(request, 'privacidade.html', context))


def news(request):
    all_posts = models.Post.objects.all()
    last_post = all_posts[0]
    logging.debug("slug = %s" % last_post.slug)
    return HttpResponseRedirect("/news/" + last_post.slug)


def news_detail(request, slug):
    post = models.Post.objects.get(slug=slug)
    all_posts = models.Post.objects.all()
    other_posts = []
    for other_post in all_posts:
        if other_post != post:
            other_posts.append(other_post)

    other_posts[:4]

    context = build_context(post=post, other_posts=other_posts)
    return HttpResponse(render(request, 'news.html', context))


@csrf_exempt
def mail(request):

    # get data
    object = json.loads(request.body)
    logging.debug(object)
    nome = object['nome']
    email = object['email']
    telefone = object['telefone']
    mensagem = object['mensagem']

    message = """Dados informados no formulario de contato:
- Nome: %s
- Email: %s
- Telefone: %s
- Mensagem:
%s""" % (nome, email, telefone, mensagem)

    logging.debug(message)

    status = send_mail(
        subject='[JBS Ambiental] Contact Form',
        from_email=config.EMAIL_FROM,
        recipient_list=[config.EMAIL_TO],
        message=message,
        fail_silently=False)

    logging.debug('status = %d' % status)
    return HttpResponse('')
