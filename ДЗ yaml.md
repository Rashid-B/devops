## Обязательная задача 1

```
 { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            # Отсутствуют ковычек
            }
        ]
    }
```



## Обязательная задача 2



```
##!/usr/bin/env python3
import socket
import datetime
import json
import yaml

srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
fpath = "F:/pro/"

print('**************************************************************************************')
print(srv)
print('**************************************************************************************')


while True:
  for host in srv:
    ip = socket.gethostbyname(host)
    if ip != srv[host]:
        print(str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip)
        with open(fpath + host + ".json", 'w') as jsf:
            json_data = json.dumps({host: ip})
            jsf.write(json_data)
            # yaml
        with open(fpath + host + ".yaml", 'w') as ymf:
            yaml_data = yaml.dump([{host: ip}])
            ymf.write(yaml_data)
    srv[host]=ip
```



```
C:\Users\rashid\PycharmProjects\pythonProject\net\venv\Scripts\python.exe C:/Users/rashid/PycharmProjects/pythonProject/net/main.py

**************************************************************************************

{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

**************************************************************************************

2021-12-20 13:11:38 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.161.194
2021-12-20 13:11:38 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.210.165
2021-12-20 13:11:38 [ERROR] google.com IP mistmatch: 0.0.0.0 216.58.209.174
2021-12-20 13:12:45 [ERROR] drive.google.com IP mistmatch: 64.233.161.194 64.233.163.194
2021-12-20 13:13:37 [ERROR] drive.google.com IP mistmatch: 64.233.163.194 64.233.161.194
```

