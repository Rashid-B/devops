# Дипломный практикум в YandexCloud

## Регистрация доменного имени

- Зарегистрирован домен `weget2u.ru`;
- Создан S3 bucket в YC аккаунте;
- Настроено управление DNS; 

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/s3.png)
>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/ip.png) 

Развертывание инфраструктуры

Развертывание инфраструктуры производится командой `terraform init && terraform plan && terraform apply --auto-approve`:

- `providers.tf` Содержит настройки для подключения к провайдеру;
- `variables.tf` Содержит описание переменных и их значения ;
- `network.tf` Содержит настройки сетей;
- `dns.txt`  Содержит настройки dns;
- `image.txt`  Содержит image;
- `app.tf`, `db01.tf`,`db02.tf`, `gitlab.tf`, `monitoring.tf`. `nginx.tf`, `runner.tf` Содержат манифесты для создания виртуальных машин в YC.
>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/vm.png)

## Установка Nginx и LetsEncrypt
Все необходимые роли находятся в каталоге `Ansible` и разделены по сервисам. 

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/cert.png)

## Установка кластера MySQL

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/check.png)

## Установка WordPress

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/wordpress.png)

## Установка Gitlab CE и Gitlab Runner

 Runner подключился к Gitlab.

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/runner.png)


Для выполнения задачи deploy из GitLab:

```
before_script:
  - eval $(ssh-agent -s)
  - echo "$ssh_key" | tr -d '\r' | ssh-add -
  - mkdir -p ~/.ssh
  - chmod 700 ~/.ssh

stages:         
  - deploy

deploy-job:      
  stage: deploy
  script:
    - echo "Deploying application..." 
    - ssh -o StrictHostKeyChecking=no ubuntu@app.weget2u.ru sudo chown ubuntu /var/www/weget2u.ru/ -R
    - rsync -vz -e "ssh -o StrictHostKeyChecking=no" ./* ubuntu@app.weget2u.ru:/var/www/weget2u.ru/
    - ssh -o StrictHostKeyChecking=no ubuntu@app.weget2u.ru rm -rf /var/www/weget2u.ru/.git
    - ssh -o StrictHostKeyChecking=no ubuntu@app.weget2u.ru sudo chown www-data /var/www/weget2u.ru/ -R
```

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/repo.png)
>
>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/do.png)

При commit в репозитории GitLab изменения будут отправляться на сервер c wordpress(app.weget2u.ru).

## Установка Prometheus, Alert Manager, Node Exporter и Grafana

Интерфейс `Grafana`, `Prometheus` и `alertmanager` теперь доступны по https. 

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/prometheus.png)

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/alert.png)

>![PID 1](https://github.com/Rashid-B/devops/blob/master/res/src/node.png)
