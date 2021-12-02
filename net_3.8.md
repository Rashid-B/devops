#### 1

https://github.com/Rashid-B/devops/blob/fix/telnet.jpg

#### 2

```
ifconfig -a
dummy0: flags=130<BROADCAST,NOARP>  mtu 1500
        inet 10.0.2.16  netmask 255.255.255.248  broadcast 0.0.0.0
        ether 22:47:dc:b0:33:a5  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

dummy1: flags=130<BROADCAST,NOARP>  mtu 1500
        inet 10.0.2.17  netmask 255.255.255.248  broadcast 0.0.0.0
        ether ae:20:7d:51:4b:e3  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:fe73:60cf  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:73:60:cf  txqueuelen 1000  (Ethernet)
        RX packets 229  bytes 222656 (222.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 228  bytes 33410 (33.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 42  bytes 3638 (3.6 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 42  bytes 3638 (3.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

```
netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
10.0.2.2        0.0.0.0         255.255.255.255 UH        0 0          0 eth0
```

```
sudo route add -net 10.0.2.18 netmask 255.255.255.255 gw 10.0.2.19

sudo route add -net 192.168.0.2 netmask 255.255.255.255 gw 10.0.2.18
```

```
netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         10.0.2.2        0.0.0.0         UG        0 0          0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
10.0.2.2        0.0.0.0         255.255.255.255 UH        0 0          0 eth0
10.0.2.18       10.0.2.19       255.255.255.255 UGH       0 0          0 eth0
192.168.0.2     10.0.2.18       255.255.255.255 UGH       0 0          0 eth0
```



#### 3

```
ss -tl
State   Recv-Q  Send-Q     Local Address:Port       Peer Address:Port  Process  
LISTEN  0       4096             0.0.0.0:sunrpc          0.0.0.0:*              
LISTEN  0       4096       127.0.0.53%lo:domain          0.0.0.0:*              
LISTEN  0       128              0.0.0.0:ssh             0.0.0.0:*              
LISTEN  0       4096                [::]:sunrpc             [::]:*              
LISTEN  0       128                 [::]:ssh                [::]:*        
```

111/TCP,UDP удаленный вызов процедур

53/TCP,UDP DNS

22/TCP,UDP SSH

#### 4

```
ss -lu
State   Recv-Q  Send-Q     Local Address:Port       Peer Address:Port  Process  
UNCONN  0       0          127.0.0.53%lo:domain          0.0.0.0:*              
UNCONN  0       0         10.0.2.15%eth0:bootpc          0.0.0.0:*              
UNCONN  0       0                0.0.0.0:sunrpc          0.0.0.0:*              
UNCONN  0       0                   [::]:sunrpc             [::]:*              
```

#### 5

https://github.com/Rashid-B/devops/blob/fix/Diagram.drawio