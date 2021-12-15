#### 1

```
ip a |awk '/state UP/{print $2}'
```

eth0:

```
netsh interface show interface
```

Состояние адм.  Состояние     Тип              Имя интерфейса

Разрешен       Подключен      Выделенный       VirtualBox Host-Only Network
Разрешен       Подключен      Выделенный       Беспроводная сеть

#### 2

Neighbor Discovery Protocol, NDP 

```
ip neighbor show
```

#### 3

VLAN

Для того, чтобы VLANы устанавливались при перезагрузки - их необходимо прописать в файле

```
vi /etc/network/interfaces
```

```
auto eth0.999
iface eth0.999 inet static
    address 10.100.10.3
    netmask 255.255.255.0
    vlan_raw_device eth0

auto eth0.100
iface eth0.100 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    vlan_raw_device eth0
```

В процессе работы VLANами можно управлять через утилиту vconfig. Например:



```
vconfig add eth0 100
```


добавить Vlan к интерфейсу eth0.



```
vconfig rem vlan100
```


Удалить VLAN.

#### 4

mode=0 (balance-rr)

mode=1 (active-backup)

mode=2 (balance-xor)

mode=3 (broadcast)

mode=4 (802.3ad)

mode=5 (balance-tlb)

mode=6 (balance-alb)

настройка интерфейса в режиме **active-backup**  

```
vi /etc/network/interfaces
auto bond0
iface bond0 inet dhcp
  bond-slaves none
  bond-mode active-backup
  bond-miimon 100

auto eth0
  iface eth0 inet manual
  bond-master bond0
  bond-primary eth0 
```



#### 5

8

32 подсети

 10.10.10.1 

 10.10.10.2 

#### 6

100.64.0.0 /26

#### 7



```
arp -a
arp -d <host>  удаляет запись, соответствующую хосту.
arp -d -a      удаляет все записи таблицы.
```
####1234
