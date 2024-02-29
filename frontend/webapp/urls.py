from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('contato', views.contato, name='contato'),
    path('produtos', views.produtos, name='produtos'),
    path('quem-somos', views.quem_somos, name='quem_somos'),
    path('gestao-de-residuos', views.servicos, name='servicos'),
    path('politica-de-privacidade', views.privacidade, name='privacidade'),
    path('news', views.news, name='news'),
    path('news/<slug:slug>', views.news_detail, name='news_detail'),
    path('mail', views.mail, name='mail'),
]
