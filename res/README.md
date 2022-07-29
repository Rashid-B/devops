# Дипломный практикум в YandexCloud

## Регистрация доменного имени

- Зарегистрирован домен `weget2u.ru`;
- Создан S3 bucket в YC аккаунте;
- Настроено управление DNS; 

>![PID 1](https://photos.app.goo.gl/yR2vZPcX3anaBdTN7)  
>
>![PID 1](https://photos.app.goo.gl/W7Xfc9xVRSug6tdq5) 

Развертывание инфраструктуры

Развертывание инфраструктуры производится командой `terraform init && terraform plan && terraform apply --auto-approve`:

- `providers.tf` Содержит настройки для подключения к провайдеру;
- `variables.tf` Содержит описание переменных и их значения ;
- `network.tf` Содержит настройки сетей;
- `dns.txt`  Содержит настройки dns;
- `image.txt`  Содержит image;
- `app.tf`, `db01.tf`,`db02.tf`, `gitlab.tf`, `monitoring.tf`. `nginx.tf`, `runner.tf` Содержат манифесты для создания виртуальных машин в YC.
>![PID 1](https://photos.app.goo.gl/o7x24DxVyfkX9r2F9)

## Установка Nginx и LetsEncrypt
Все необходимые роли находятся в каталоге `Ansible` и разделены по сервисам. 



>![PID 1](https://photos.app.goo.gl/6qFHWA9rytCbSsEq6)

## Установка кластера MySQL

>![PID 1](https://photos.app.goo.gl/DAxwxAdWg2soHPbu7)

## Установка WordPress

>![PID 1](https://photos.app.goo.gl/U1w9aqentYr7Ydyt7)

## Установка Gitlab CE и Gitlab Runner

 Runner подключился к Gitlab.

>![PID 1](https://photos.app.goo.gl/y8Figmockr48FGvY6)


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

>![PID 1](https://photos.app.goo.gl/Htxj8M6sj6do8uEs8)
>
>![PID 1](https://photos.app.goo.gl/ntbfSTdj1TUk6a8q6)

При commit в репозитории GitLab изменения будут отправляться на сервер c wordpress(app.weget2u.ru).

## Установка Prometheus, Alert Manager, Node Exporter и Grafana

Интерфейс `Grafana`, `Prometheus` и `alertmanager` теперь доступны по https. 

>![PID 1](https://photos.app.goo.gl/qNgwM9rAkSH7Jw2Z8)

>![PID 1](https://photos.app.goo.gl/5a8yd1SjuvJpnpJr7)
>
>![PID 1](https://photos.app.goo.gl/3Zjm69LKiGZVE11U6)
