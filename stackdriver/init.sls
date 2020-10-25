stackdriver-agent-installed:
  cmd.script:
    - name: salt://scripts/stackdriver/stackdriver-install.sh
    - cwd: /tmp
    - args: --write-gcm
    {% if grains['os_family'] == 'RedHat' %}
    - unless: rpm --query stackdriver-agent
    {% elif grains['os_family'] == 'Debian' %}
    - unless: dpkg -s stackdriver-agent
    {% endif %}

stackdriver-agent-running:
  service.running:
    - name: stackdriver-agent
    - enable: True
    - require:
      - stackdriver-agent-installed
