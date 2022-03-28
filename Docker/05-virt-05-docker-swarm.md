## Задача 1

Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?

  - В режиме `replicated` сервис разворачивается в  количестве которое укажет пользователь. Обычно разветвляются по узлам, но также могут быть размещены на одной ноде.

    В режиме `global` сервис будет развернут с одной репликой на каждой ноде. 

- Какой алгоритм выбора лидера используется в Docker Swarm кластере?

  - Алгоритм поддержания распределенного консенсуса — Raft

- Что такое Overlay Network?

  - Подсеть, которую могут использовать контейнеры в разных хостах swarm-кластера. Overlay-сеть использует технологию vxlan

## 

## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

```
docker node ls
```

```
[root@node02 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
ax59z37a61xpegxbwacgo3w47     node01.netology.yc   Ready     Active         Leader           20.10.12
a4665hi678x4xjsnezndd1p64 *   node02.netology.yc   Ready     Active         Reachable        20.10.12
cbugk1bz7trcd1z5ktglwhyf1     node03.netology.yc   Ready     Active         Reachable        20.10.12
bwd582vn46wp0dy1glmiog1cl     node04.netology.yc   Ready     Active                          20.10.12
yakdiz5i5s97akccv4p196ojt     node05.netology.yc   Ready     Active                          20.10.12
3z0zhhzrpuhhh9xui0cn839v9     node06.netology.yc   Ready     Active                          20.10.12
```



## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

```
docker service ls
```

```
[root@node02 ~]# docker stack ls
NAME               SERVICES   ORCHESTRATOR
swarm_monitoring   8          Swarm
[root@node02 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
mwi3jo3o45hh   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0    
eg6harwwgc9c   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
xvdihvot36vi   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest                         
eul1s5tnu1fc   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest                      
lz5gyhmihwnz   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4           
pxey4iu80cb5   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0   
1s6rddz9y2fs   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0       
yjtjano0rcr7   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0  
```



## Задача 4 (*)

Выполнить на лидере Docker Swarm кластера команду  (указанную ниже) и дать письменное описание её функционала, что она  делает и зачем она нужна:

```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```

```
[root@node02 ~]# docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-SF/HF5crritJpj5MyBe+M+E0PzUFU688bpaOvYpuDV0

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
[root@node02 ~]# service docker restart
Redirecting to /bin/systemctl restart docker.service
[root@node02 ~]# docker node ls
Error response from daemon: Swarm is encrypted and needs to be unlocked before it can be used. Please use "docker swarm unlock" to unlock it.
[root@node02 ~]# docker swarm unlock
Please enter unlock key: 
```

Лог Raft зашифрован на диске, для защиты конфигурацию и данных сервисов от злоумышленников, которые получают доступ к зашифрованным логам Raft. Данная команда активирует функцию автоблокировки. В случае перезапуска `Docker` требуется ввести пользовательский ключ разблокировки.