## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

```
root@rashid-NBD:~# docker run --rm --name my_psql \
> -e POSTGRES_DB=test_db \
> -e POSTGRES_PASSWORD=pass \
> -e PGDATA=/var/lib/postgresql/data/pgdata \
> -v data:/var/lib/postgresql/data \
> -p 5432:5432 \
> -d postgres:13 
root@rashid-NBD:~# docker exec -it a1c0ddf65593 bash
root@a1c0ddf65593:/# psql -h localhost -p 5432 -U postgres -W

root@rashid-NBD:~# docker exec -it a1c0ddf65593 bash
root@a1c0ddf65593:/# su - postgres
postgres@a1c0ddf65593:~$ psql
psql (13.6 (Debian 13.6-1.pgdg110+1))
Type "help" for help.

postgres=# 
```

**Найдите и приведите** управляющие команды для:

- вывода списка БД

  ```
  \l[+]   [PATTERN]      list databases
  ```

- подключения к БД

  ```
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                           connect to new database (currently "postgres")
  ```

- вывода списка таблиц

  ```
  \dt[S+] [PATTERN]      list tables
  ```

- вывода описания содержимого таблиц

  ```
  \d[S+]  NAME           describe table, view, sequence, or index
  ```

- выхода из psql

  ```
  \q                     quit psql
  ```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

```
root@rashid-NBD:~# docker cp test_dump.sql a1c0ddf65593:/var/tmp/test_dump.sql
root@rashid-NBD:~# docker exec -it a1c0ddf65593 bash
root@a1c0ddf65593:/# su - postgres
postgres@a1c0ddf65593:~$ psql test_database < /var/tmp/test_dump.sql
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
postgres@a1c0ddf65593:~$ 
```

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
test_database=#  \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# 
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

```
test_database=# SELECT avg_width FROM pg_stats WHERE tablename = 'orders' order by avg_width desc limit 1;
 avg_width 
-----------
        16
(1 row)

test_database=# 
```

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

```
start transaction;

 alter table public.orders rename to orders_old;
 
 CREATE TABLE public.orders (
      like public.orders_old
      including defaults
      including constraints
      including indexes
  );

  CREATE TABLE public.orders_1 (
      check (price>499)
  ) inherits (public.orders);

  CREATE TABLE public.orders_2 (
      check (price<=499)
  ) inherits (public.orders);

  ALTER TABLE public.orders_1 OWNER TO postgres;
  ALTER TABLE public.orders_2 OWNER TO postgres;

  create rule orders_insert_over_499 as on insert to public.orders
  where (price>499)
  do instead insert into public.orders_1 values(NEW.*);

  create rule orders_insert_499_or_less as on insert to public.orders
  where (price<=499)
  do instead insert into public.orders_2 values(NEW.*);

  INSERT INTO public.orders (id,title,price) select id,title,price from public.orders_old;

  ALTER TABLE public.orders_old alter id drop default;
  ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;

  drop table public.orders_old;

end;
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Да, это можно сделать

```
drop table public.orders cascade;

CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
);
ALTER TABLE public.orders OWNER TO postgres;

CREATE TABLE public.orders_1 (
    check (price>499)
) inherits (public.orders);

CREATE TABLE public.orders_2 (
    check (price<=499)
) inherits (public.orders);

ALTER TABLE public.orders_1 OWNER TO postgres;
ALTER TABLE public.orders_2 OWNER TO postgres;

create rule orders_insert_over_499 as on insert to public.orders
where (price>499)
do instead insert into public.orders_1 values(NEW.*);

create rule orders_insert_499_or_less as on insert to public.orders
where (price<=499)
do instead insert into public.orders_2 values(NEW.*);

```



## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

```
pg_dump -f /var/tmp/my_dump.sql -h localhost -p 5432 -U postgres test_database
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

Я бы добавил признак `UNIQUE`

```
    title character varying(80) UNIQUE,
```

