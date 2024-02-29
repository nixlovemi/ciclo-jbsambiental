# ciclo-jbsambiental
- Need to install each module (double check before installing)
    - pip3 install mysqlclient (probably code is commented | root/settings.py)
    - brew install pkgconfig
    - brew install zeromq
    - pip install django-ckeditor --upgrade
    - python3 -m pip install django

- To run locally
    - python3 manage.py runserver 8000

- To deploy, check email "Chaves privadas"


> Esse repositorio contem o codigo para o projeto da JBS Ambiental (www.jbsambiental.com.br).
> 
> ## Stack
> 
> - Linux (Ubuntu 18.04)
> - Python 3+
> - DJango
> - SaltStack (configuration management)
> 
> ## Estrutura de pastas
>
> - config: Configuracoes.
> - frontend: Codigo principal do site.
> - keys: Chaves de acesso a servidores (PEM files).
> - salt: Scripts de Configuracao (SaltStack).
> 
> ## Ambiente de Desenvolvimento
> 
> O ambiente de desenvolvimento pode ser configurado usando Vagrant.