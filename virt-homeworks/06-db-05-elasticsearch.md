## Задача 1

В этом задании вы потренируетесь в:

- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и [документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:

- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:

- текст Dockerfile манифеста

  ```
  FROM centos:7
  
  EXPOSE 9200 9300
  
  RUN yum -y install wget && \
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz && \
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz.sha512 && \
      yum install perl-Digest-SHA -y && \
      sha512sum -c elasticsearch-8.0.1-linux-x86_64.tar.gz.sha512 && \ 
      tar -xzf elasticsearch-8.0.1-linux-x86_64.tar.gz && \
      rm -f elasticsearch-8.0.1-linux-x86_64.tar.gz* && \
      mv elasticsearch-8.0.1 /var/lib/elasticsearch && \
      mkdir /var/lib/elasticsearch/snapshots && \
      useradd -m elasticsearch && \
      chown elasticsearch:elasticsearch -R /var/lib/elasticsearch && \
      yum -y remove wget && \
      yum clean all
      
  COPY --chown=elasticsearch:elasticsearch ./elasticsearch.yml /var/lib/elasticsearch/config
  
  USER elasticsearch:elasticsearch
  
  ENV ES_HOME="/var/lib/elasticsearch" \
      ES_PATH_CONF="/var/lib/elasticsearch/config"
      
  WORKDIR /var/lib/elasticsearch
  
  CMD ["/bin/sh", "-c", "/var/lib/elasticsearch/bin/elasticsearch"]
  
  
  ```

  

- ссылку на образ в репозитории dockerhub

  ```
  https://hub.docker.com/repository/docker/redvol/elk
  ```

- ответ `elasticsearch` на запрос пути `/` в json виде

  ```
  {
    "name" : "netology_test",
    "cluster_name" : "my-application",
    "cluster_uuid" : "_na_",
    "version" : {
      "number" : "8.0.1",
      "build_flavor" : "default",
      "build_type" : "tar",
      "build_hash" : "801d9ccc7c2ee0f2cb121bbe22ab5af77a902372",
      "build_date" : "2022-02-24T13:55:40.601285296Z",
      "build_snapshot" : false,
      "lucene_version" : "9.0.0",
      "minimum_wire_compatibility_version" : "7.17.0",
      "minimum_index_compatibility_version" : "7.0.0"
    },
    "tagline" : "You Know, for Search"
  }
  ```

  



## Задача 2

В этом задании вы научитесь:

- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя   | Количество реплик | Количество шард |
| ----- | ----------------- | --------------- |
| ind-1 | 0                 | 1               |
| ind-2 | 1                 | 2               |
| ind-3 | 2                 | 4               |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

```
rashid@rashid-NBD:~/netology/docker_sample$ curl 'localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 M3Y3q45bSFGcze7ZVecM0w   1   0          0            0       225b           225b
yellow open   ind-3 3UtNzlNHS4O4luRAvvmvYQ   4   2          0            0       900b           900b
yellow open   ind-2 8qSUT5_URj-6r7K1Ht0P-A   2   1          0            0       450b           450b
```

Получите состояние кластера `elasticsearch`, используя API.

```
rashid@rashid-NBD:~/netology/docker_sample$ curl -X GET "localhost:9200/_cluster/health?pretty"
{
  "cluster_name" : "my-application",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```
У них должны быть реплики, но в кластере всего одна нода, поэтому размещать их негде.
Соответственно кластер помечает их желтыми
```

Удалите все индексы.

```
rashid@rashid-NBD:~/netology/docker_sample$ curl -X DELETE 'http://localhost:9200/_all'
{"acknowledged":true}
```

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард, иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:

- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

```
Создал изначально в манифесте
```

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```
curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/var/lib/elasticsearch/snapshots",
    "compress": true
  }
}
'
{
  "acknowledged" : true
}
```

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test   7pxpU9BlYDih247ZCndmT   1   0          0            0       225b           225b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

```
rashid@rashid-NBD:~/netology/docker_sample$ sudo docker exec -it elk ls -l /var/lib/elasticsearch/snapshots/
total 36
-rw-r--r-- 1 elasticsearch elasticsearch   589 Mar  4 16:10 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Mar  4 16:10 index.latest
drwxr-xr-x 3 elasticsearch elasticsearch  4096 Mar  4 16:10 indices
-rw-r--r-- 1 elasticsearch elasticsearch 17056 Mar  4 16:10 meta-0MD0K0GyRFSScyHHXW0OIQ.dat
-rw-r--r-- 1 elasticsearch elasticsearch   309 Mar  4 16:10 snap-0MD0K0GyRFSScyHHXW0OIQ.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```
rashid@rashid-NBD:~/netology/docker_sample$ curl 'localhost:9200/_cat/indices?pretty'
green open test-2 DRWOBFiIQLGfJqyfSXDuEA 1 0 0 0 225b 225b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние кластера `elasticsearch` из `snapshot`, созданного ранее.

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```
rashid@rashid-NBD:~/netology/docker_sample$ curl -X POST 'http://localhost:9200/.*/_close?pretty'
{
  "acknowledged" : true,
  "shards_acknowledged" : false,
  "indices" : { }
}
rashid@rashid-NBD:~/netology/docker_sample$ curl -X POST 'http://localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?wait_for_completion=true'
{"snapshot":{"snapshot":"elasticsearch","indices":["test"],"shards":{"total":1,"failed":0,"successful":1}}}
rashid@rashid-NBD:~/netology/docker_sample$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 DRWOBFiIQLGfJqyfSXDuEA   1   0          0            0       225b           225b
green  open   test   CewZE72KSNiGMGNISKwXpA   1   0          0            0       225b           225b
```

