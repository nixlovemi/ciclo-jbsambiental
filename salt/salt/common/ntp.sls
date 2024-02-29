ntp_installed:
  pkg:
    - name: ntp
    - installed

ntp_running_and_enabled:
  service.running:
    - name: ntp
    - enable: True
