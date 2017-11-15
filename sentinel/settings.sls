{%- set g  = salt['grains.get']('sentinel', {}) %}
{%- set cluster_id = g.get('cluster_id', None) %}
{%- set p = salt['pillar.get']('sentinel', {}) %}
{%- set redis_master_ip = p.clusters[''+cluster_id[0]] %}
{%- set mastername = p.get('mastername', 'mymaster') %}
{%- set sentinel = {} %}
{%- do sentinel.update({
  'cluster_id': cluster_id,
  'redis_master_ip': redis_master_ip,
  'mastername': mastername,
}) %}
