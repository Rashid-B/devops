## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

  ```
  <html>
  <head>
  Hey, Netology
  </head>
  <body>
  <h1>I’m DevOps Engineer!</h1>
  </body>
  </html>
  ```

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

-  Создаем директорию www с файлом index.html, содержащей HTML-код

-  Создаем **Dockerfile**

  ```
  FROM nginx:1.21.6-alpine
  
  COPY www /usr/share/nginx/html
  
  EXPOSE 80
  ```

- Создаем **Docker image**

  ```
  rashid@rashid-NBD:~/docker_sample$ docker build -t test_docker .
  Sending build context to Docker daemon  3.584kB
  Step 1/3 : FROM nginx:1.21.6-alpine
  1.21.6-alpine: Pulling from library/nginx
  59bf1c3509f3: Pull complete 
  8d6ba530f648: Pull complete 
  5288d7ad7a7f: Pull complete 
  39e51c61c033: Pull complete 
  ee6f71c6f4a8: Pull complete 
  f2303c6c8865: Pull complete 
  Digest: sha256:da9c94bec1da829ebd52431a84502ec471c8e548ffb2cedbf36260fd9bd1d4d3
  Status: Downloaded newer image for nginx:1.21.6-alpine
   ---> bef258acf10d
  Step 2/3 : COPY www /usr/share/nginx/html
   ---> 15c65d0b5461
  Step 3/3 : EXPOSE 80
   ---> Running in d6d09f9ce3a9
  Removing intermediate container d6d09f9ce3a9
   ---> b096312192b7
  Successfully built b096312192b7
  Successfully tagged test_docker:latest
  ```

- Запускаем контейнер, на основе созданного образа

  ```
  rashid@rashid-NBD:~/docker_sample$ docker run -d -p 8080:80      redvol/nginx:1.0
  0fd8ef0ad7d75210fb7cdcedd22a58f5b698883ad3d811876b85394030a39b21
  ```

- Проверяем в браузере https://photos.app.goo.gl/oCLjW7nRRzGGBEnH9

- Логинимся в **Docker** 

  ```
  rashid@rashid-NBD:~/docker_sample$ docker login
  Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to   https://hub.docker.com to create one.
  Username: redvol
  Password: 
  WARNING! Your password will be stored unencrypted in /home/rashid/.docker/config.json.
  Configure a credential helper to remove this warning. See
  https://docs.docker.com/engine/reference/commandline/login/#credentials-store
  
  Login Succeeded
  ```
  
- Отправляем созданный **Docker image** в репозиторий

  ```
  rashid@rashid-NBD:~/docker_sample$ docker image ls
  REPOSITORY     TAG             IMAGE ID       CREATED          SIZE
  redvol/nginx   1.0             0843e82f9e2e   21 minutes ago   23.4MB
  nginx          1.21.6-alpine   bef258acf10d   4 days ago       23.4MB
  rashid@rashid-NBD:~/docker_sample$ docker push redvol/nginx:1.0
  The push refers to repository [docker.io/redvol/nginx]
  9be2c1add427: Pushed 
  6fda88393b8b: Mounted from library/nginx 
  a770f8eba3cb: Mounted from library/nginx 
  318191938fd7: Mounted from library/nginx 
  89f4d03665ce: Mounted from library/nginx 
  67bae81de3dc: Mounted from library/nginx 
  8d3ac3489996: Mounted from library/nginx 
  1.0: digest: sha256:fcc89fc9f6d492b964de0042a56618b5e65287bbb6c4a48787a9a6bf1588f282 size: 1775
  ```

- https://hub.docker.com/repository/docker/redvol/nginx

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше  подойдет виртуальная машина, физическая машина? Может быть возможны  разные варианты?"

Детально опишите и обоснуйте свой выбор.

\--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;  Физический сервер. Монолитное приложение не получится использовать в микросерверах, и плюс высоконагруженное.
- Nodejs веб-приложение; Для веб-приложений будет оптимально использовать docker
- Мобильное приложение c версиями для Android и iOS; Виртуальная машина
- Шина данных на базе Apache Kafka; Виртуальная машина, проще защитить передаваемые данные
- Elasticsearch кластер для реализации логирования продуктивного  веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; docker есть образ в репозитории
- Мониторинг-стек на базе Prometheus и Grafana; Можно использовать docker. быстро разворачивать и масштабировать
- MongoDB, как основное хранилище данных для java-приложения; Виртуальная машина, если не высоконагруженное хранилище. 
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  Docker, потому что требуется построение CI/CD процессов 

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку `/data` из текущей рабочей директории на хостовой машине в `/data` контейнера; Подключитесь к первому контейнеру с помощью `docker exec` и создайте текстовый файл любого содержания в `/data`;

  ```
  rashid@rashid-NBD:~/docker_sample$ docker run -ti -v /home/rashid/docker_sample/data:/data centos:8.4.2105
  [root@64a32e2f6138 /]# ls
  bin  data  dev	etc  home  lib	lib64  lost+found  media  mnt  opt  proc  root	run  sbin  srv	sys  tmp  usr  var
  [root@64a32e2f6138 /]# cd data
  [root@64a32e2f6138 data]# ls
  host.txt
  [root@64a32e2f6138 data]# touch centos.txt
  [root@64a32e2f6138 data]# ls
  centos.txt  host.txt
  [root@64a32e2f6138 data]# 
  ```

- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку `/data` из текущей рабочей директории на хостовой машине в `/data` контейнера; Подключитесь во второй контейнер и отобразите листинг и содержание файлов в `/data` контейнера.

  ```
  rashid@rashid-NBD:~/docker_sample$ docker run -ti -v /home/rashid/docker_sample/data:/data debian:11.2
  root@66160c5f5c50:/# ls
  bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
  root@66160c5f5c50:/# cd data
  root@66160c5f5c50:/data# ls
  centos.txt  host.txt
  ```

- Добавьте еще один файл в папку `/data` на хостовой машине;

  ```
  rashid@rashid-NBD:~/docker_sample$ cd data
  rashid@rashid-NBD:~/docker_sample/data$ touch host.txt
  rashid@rashid-NBD:~/docker_sample/data$ ls
  host.txt
  ```
  
  

