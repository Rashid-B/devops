# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 


## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
    dynamodb.
    * иначе будет создан локальный файл со стейтами.  
    
1. Создайте два воркспейса `stage` и `prod`.

    ```
    ioi@ioi-Pro:~/DevOps/terraform/07-terraform-02-syntax$ terraform workspace new stage
    Created and switched to workspace "stage"!
    
    You're now on a new, empty workspace. Workspaces isolate their state,
    so if you run "terraform plan" Terraform will not see any existing state
    for this configuration.
    ioi@ioi-Pro:~/DevOps/terraform/07-terraform-02-syntax$ terraform workspace new prod
    Created and switched to workspace "prod"!
    
    You're now on a new, empty workspace. Workspaces isolate their state,
    so if you run "terraform plan" Terraform will not see any existing state
    for this configuration.
    ioi@ioi-Pro:~/DevOps/terraform/07-terraform-02-syntax$ terraform workspace list
      default
    * prod
      stage
    
    ```

1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
    использовались разные `instance_type`.

1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 

1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.

1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
    жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.

1. При желании поэкспериментируйте с другими параметрами и рессурсами.

    ```
    ioi@ioi-Pro:~/DevOps/terraform/07-terraform-02-syntax$ terraform plan
    
    Terraform used the selected providers to generate the following execution plan.
    Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # heroku_app.test will be created
      + resource "heroku_app" "test" {
          + acm                   = (known after apply)
          + all_config_vars       = (sensitive value)
          + buildpacks            = (known after apply)
          + config_vars           = (known after apply)
          + git_url               = (known after apply)
          + heroku_hostname       = (known after apply)
          + id                    = (known after apply)
          + internal_routing      = (known after apply)
          + name                  = "case-heroku"
          + region                = "us"
          + sensitive_config_vars = (sensitive value)
          + stack                 = "heroku-20"
          + uuid                  = (known after apply)
          + web_url               = (known after apply)
        }
    
      # heroku_build.test will be created
      + resource "heroku_build" "test" {
          + app_id            = (known after apply)
          + buildpacks        = (known after apply)
          + id                = (known after apply)
          + local_checksum    = "SHA256:04dce8f8457e48afe517ca8b534f3aad398e2f33e259056cee80b2a91bf708b4"
          + output_stream_url = (known after apply)
          + release_id        = (known after apply)
          + slug_id           = (known after apply)
          + stack             = (known after apply)
          + status            = (known after apply)
          + user              = (known after apply)
          + uuid              = (known after apply)
    
          + source {
              + checksum = (known after apply)
              + path     = "./app"
            }
        }
    
      # heroku_formation.test will be created
      + resource "heroku_formation" "test" {
          + app_id   = (known after apply)
          + id       = (known after apply)
          + quantity = 2
          + size     = "Free"
          + type     = "web"
        }
    
      # heroku_formation.test-2["prode"] will be created
      + resource "heroku_formation" "test-2" {
          + app_id   = (known after apply)
          + id       = (known after apply)
          + quantity = 1
          + size     = "Free"
          + type     = "web"
        }
    
      # heroku_formation.test-2["stage"] will be created
      + resource "heroku_formation" "test-2" {
          + app_id   = (known after apply)
          + id       = (known after apply)
          + quantity = 1
          + size     = "Free"
          + type     = "web"
        }
    
    Plan: 5 to add, 0 to change, 0 to destroy.
    
    ```
    
    

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
* Вывод команды `terraform plan` для воркспейса `prod`.  

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
