Basic Redis Sentinel RHEL/CentOS 7
==================================
## Update pillar
 - Add sentinel cluster(s) to sentinel.sls pillar (see pillar.example)

 - Add to top.sls pillar  
```
'roles:redis_master':
  - sentinel
'roles:redis_slave':
  - sentinel
```
## Configure minions

### Sentinel redis master minion config, with required role, sentinel:cluster_id and mine_functions:
```
grains:
  roles:
    - redis_master
  sentinel:
    cluster_id:
      - stable
```

### Sentinel redis slave minion config, with required role, sentinel:cluster_id and mine_functions:
```
grains:
  roles:
    - redis_slave
  sentinel:
    cluster_id:
      - stable
```
