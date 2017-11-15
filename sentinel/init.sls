{%- from 'sentinel/settings.sls' import sentinel with context -%}

epel_release:
  pkg.installed:
    - name: epel-release

redis_pkg:
  pkg.installed:
    - name: redis
    - require:
      - epel_release

redis_services:
  service.running:
    - enable: True
    - names:
      - redis
      - redis-sentinel
    - watch:
      - file: /etc/redis.conf
      - file: /etc/redis-sentinel.conf
    - require:
      - redis_pkg

redis_conf:
  file.managed:
    - template: jinja
    - name: /etc/redis.conf
    - source: salt://sentinel/files/redis.conf
    - require:
      - redis_pkg
    - context:
      redis_master_ip: {{ sentinel.redis_master_ip }}
sentinel_conf:
  file.managed:
    - template: jinja
    - name: /etc/redis-sentinel.conf
    - source: salt://sentinel/files/redis-sentinel.conf
    - require:
      - redis_pkg
    - context:
      redis_master_ip: {{ sentinel.redis_master_ip }}
      mastername: {{ sentinel.mastername }}
