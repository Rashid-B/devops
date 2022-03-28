## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```
docker-compose.yaml
```

```
version: "3.3"

volumes:
  data: {}
  backup: {}
  
services:
  postgres:
    image: postgres:12.0
    container_name: psql
    restart: always
    environment:
      POSTGRES_DB: "test_db"
      POSTGRES_USER: "admin_db"
      POSTGRES_PASSWORD: "password"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/var/tmp
    ports:
      - "0.0.0.0:5432:5432"
```

```
rashid@Aquarius-Pro:~/06-db-02-sql$ sudo docker-compose up -d
rashid@Aquarius-Pro:~/06-db-02-sql$ psql -h localhost -U admin_db test_db
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 12.0 (Debian 12.0-2.pgdg100+1))
Type "help" for help.

test_db-# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin_db          +
           |          |          |            |            | admin_db=CTc/admin_db
 template1 | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin_db          +
           |          |          |            |            | admin_db=CTc/admin_db
 test_db   | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | 

```



## Задача 2

В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:

- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:

- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:

- итоговый список БД после выполнения пунктов выше,

  ```
  test_db=# \l
                                   List of databases
     Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
  -----------+----------+----------+------------+------------+-----------------------
   postgres  | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | 
   template0 | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin_db          +
             |          |          |            |            | admin_db=CTc/admin_db
   template1 | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | =c/admin_db          +
             |          |          |            |            | admin_db=CTc/admin_db
   test_db   | admin_db | UTF8     | en_US.utf8 | en_US.utf8 | 
  (4 rows)
  ```

- описание таблиц (describe)

  ```
  test_db=# \d orders
                                 Table "public.orders"
      Column    |  Type   | Collation | Nullable |              Default               
  --------------+---------+-----------+----------+------------------------------------
   id           | integer |           | not null | nextval('orders_id_seq'::regclass)
   наименование | text    |           |          | 
   цена         | integer |           |          | 
  Indexes:
      "orders_pkey" PRIMARY KEY, btree (id)
  Referenced by:
      TABLE "clients" CONSTRAINT "fk_orders" FOREIGN KEY ("заказ") REFERENCES orders(id)
  
  test_db=# \d clients
                                    Table "public.clients"
        Column       |  Type   | Collation | Nullable |               Default               
  -------------------+---------+-----------+----------+-------------------------------------
   id                | integer |           | not null | nextval('clients_id_seq'::regclass)
   фамилия           | text    |           |          | 
   страна_проживания | text    |           |          | 
   заказ             | integer |           |          | 
  Indexes:
      "clients_pkey" PRIMARY KEY, btree (id)
  Foreign-key constraints:
      "fk_orders" FOREIGN KEY ("заказ") REFERENCES orders(id)
  
  ```

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

- список пользователей с правами над таблицами test_db

  ```
  test_db=# SELECT * from information_schema.table_privileges WHERE grantee LIKE 'test%';
   grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
  ----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
   admin_db | test_admin_user  | test_db       | public       | orders     | INSERT         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | orders     | SELECT         | NO           | YES
   admin_db | test_admin_user  | test_db       | public       | orders     | UPDATE         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | orders     | DELETE         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | INSERT         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | SELECT         | NO           | YES
   admin_db | test_admin_user  | test_db       | public       | clients    | UPDATE         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | DELETE         | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
   admin_db | test_admin_user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
   admin_db | test_simple_user | test_db       | public       | orders     | INSERT         | NO           | NO
   admin_db | test_simple_user | test_db       | public       | orders     | SELECT         | NO           | YES
   admin_db | test_simple_user | test_db       | public       | orders     | UPDATE         | NO           | NO
   admin_db | test_simple_user | test_db       | public       | orders     | DELETE         | NO           | NO
   admin_db | test_simple_user | test_db       | public       | clients    | INSERT         | NO           | NO
   admin_db | test_simple_user | test_db       | public       | clients    | SELECT         | NO           | YES
   admin_db | test_simple_user | test_db       | public       | clients    | UPDATE         | NO           | NO
   admin_db | test_simple_user | test_db       | public       | clients    | DELETE         | NO           | NO
  
  ```



## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

| Наименование | цена |
| ------------ | ---- |
| Шоколад      | 10   |
| Принтер      | 3000 |
| Книга        | 500  |
| Монитор      | 7000 |
| Гитара       | 4000 |

Таблица clients

| ФИО                  | Страна проживания |
| -------------------- | ----------------- |
| Иванов Иван Иванович | USA               |
| Петров Петр Петрович | Canada            |
| Иоганн Себастьян Бах | Japan             |
| Ронни Джеймс Дио     | Russia            |
| Ritchie Blackmore    | Russia            |

Используя SQL синтаксис:

- вычислите количество записей для каждой таблицы

- приведите в ответе:

  - запросы

  - результаты их выполнения.

```
    test_db=# select * from orders;
     id | наименование | цена 
    ----+--------------+------
      1 | Шоколад      |   10
      2 | Принтер      | 3000
      3 | Книга        |  500
      4 | Монитор      | 7000
      5 | Гитара       | 4000
    (5 rows)
    
    test_db=# select * from clients;
     id |       фамилия        | страна_проживания | заказ 
    ----+----------------------+-------------------+-------
      1 | Иванов Иван Иванович | USA               |      
      2 | Петров Петр Петрович | Canada            |      
      3 | Иоганн Себастьян Бах | Japan             |      
      4 | Ронни Джеймс Дио     | Russia            |      
      5 | Ritchie Blackmore    | Russia            |      
    (5 rows)
    
```

​    

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

| ФИО                  | Заказ   |
| -------------------- | ------- |
| Иванов Иван Иванович | Книга   |
| Петров Петр Петрович | Монитор |
| Иоганн Себастьян Бах | Гитара  |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

Подсказк - используйте директиву `UPDATE`.

```
test_db=# update clients set заказ = (select id from orders where наименование = 'Книга') where фамилия = 'Иванов Иван Иванович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Монитор') where фамилия = 'Петров Петр Петрович';
UPDATE 1
test_db=# update clients set заказ = (select id from orders where наименование = 'Гитара') where фамилия = 'Иоганн Себастьян Бах';
UPDATE 1
test_db=# select * from clients c join orders o on заказ = o.id;
 id |       фамилия        | страна_проживания | заказ | id | наименование | цена 
----+----------------------+-------------------+-------+----+--------------+------
  1 | Иванов Иван Иванович | USA               |     3 |  3 | Книга        |  500
  2 | Петров Петр Петрович | Canada            |     4 |  4 | Монитор      | 7000
  3 | Иоганн Себастьян Бах | Japan             |     5 |  5 | Гитара       | 4000
(3 rows)

```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

```
test_db=# explain select * from clients c join orders o on заказ = o.id;
                               QUERY PLAN                                
-------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=112)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=40)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=40)
(5 rows)
Данная команда показывает как будет выполняться запрос. Какие таблицы будут сканироваться. И сколько условного времени он занимает.

```



## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```
test_db=# pg_dump -h localhost -U admin_db --format=custom --clean --create --if-exists -f /var/tmp/test_db.custom test_db

rashid@Aquarius-Pro:~$ sudo docker ps
[sudo] пароль для rashid: 
CONTAINER ID   IMAGE           COMMAND                  CREATED             STATUS             PORTS                    NAMES
4099fdbd8563   postgres:12.0   "docker-entrypoint.s…"   About an hour ago   Up About an hour   0.0.0.0:5432->5432/tcp   psql
rashid@Aquarius-Pro:~$ sudo docker stop 4099fdbd8563
4099fdbd8563
rashid@Aquarius-Pro:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
rashid@Aquarius-Pro:~/06-db-02-sql$ sudo docker-compose up -d
[sudo] пароль для rashid: 
Starting psql ... done
rashid@Aquarius-Pro:~/06-db-02-sql$ sudo docker ps
CONTAINER ID   IMAGE           COMMAND                  CREATED             STATUS          PORTS                    NAMES
4099fdbd8563   postgres:12.0   "docker-entrypoint.s…"   About an hour ago   Up 12 seconds   0.0.0.0:5432->5432/tcp   psql
rashid@Aquarius-Pro:~/06-db-02-sql$ psql -h localhost -U admin_db test_db
Password for user admin_db: 
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 12.0 (Debian 12.0-2.pgdg100+1))
Type "help" for help.
test_db-# pg_restore --create --file=/var/tmp/pg_script /var/tmp/test_db.custom
test_db-# psql -f /var/tmp/restore_script
```