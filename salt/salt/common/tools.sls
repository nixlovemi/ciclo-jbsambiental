{% set tools = ['curl', 'git', 'htop', 'net-tools', 'psmisc', 'telnet', 'unzip', 'zip', 'wget'] %}

{% for tool in tools %}
{{ tool }}_installed:
  pkg:
    - name: {{ tool }}
    - installed
{% endfor %}
