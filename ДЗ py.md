## Обязательная задача 1

```
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

| Вопрос                                         | Ответ                                                  |
| ---------------------------------------------- | ------------------------------------------------------ |
| Какое значение будет присвоено переменной `c`? | Ошибка операция производится над разными типами данных |
| Как получить для переменной `c` значение 12?   | c=str(a)+b                                             |
| Как получить для переменной `c` значение 3?    | c=a+int(b)                                             |



## Обязательная задача 2

```
#!/usr/bin/env python3

import os

bash_command = ["cd C:\\Users\\rashid\\devops", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\\tmodified:   ', '')
        print(prepare_result)
        
#убрал переменную is_change и выход break
```

#### Вывод скрипта после запуска

```
C:\Users\rashid\PycharmProjects\pythonProject\net\venv\Scripts\python.exe C:/Users/rashid/PycharmProjects/pythonProject/net/main.py
On branch fix
Your branch is ahead of 'origin/fix' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   sc.py

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    README1.md
	modified:   sc.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.idea/
	"\320\224\320\227 py.md"



Process finished with exit code 0
```



## Обязательная задача 3

```
#!/usr/bin/env python3

import os
import sys
cd = os.getcwd()

if len(sys.argv)>=2:
    cd = sys.argv[1]

bash_command = ["cd "+cd, "git status"]
#bash_command = ["cd C:\\Users\\rashid\\devops", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\\tmodified:   ', '')
        print(cd+prepare_result)

```



```
fatal: not a git repository (or any of the parent directories): .git
```





## Обязательная задача 4

#### Скрипт:

```
##!/usr/bin/env python3

import socket
import datetime

srv = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}


print('********************')
print(srv)
print('********************')


while 1==1 :
  for host in srv:
    ip = socket.gethostbyname(host)
    if ip != srv[host]:
        print(str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip)
    srv[host]=ip

```

#### Вывод скрипта при запуске при тестировании:

```
C:\Users\rashid\PycharmProjects\pythonProject\net\venv\Scripts\python.exe C:/Users/rashid/PycharmProjects/pythonProject/net/main.py
********************
{'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}
********************
2021-12-18 12:05:29 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 64.233.161.194
2021-12-18 12:05:29 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.210.165
2021-12-18 12:05:29 [ERROR] google.com IP mistmatch: 0.0.0.0 216.58.209.174
2021-12-18 12:29:12 [ERROR] drive.google.com IP mistmatch: 64.233.161.194 64.233.163.194
2021-12-18 12:30:12 [ERROR] drive.google.com IP mistmatch: 64.233.163.194 64.233.161.194
2021-12-18 12:34:13 [ERROR] drive.google.com IP mistmatch: 64.233.161.194 64.233.163.194
2021-12-18 12:35:30 [ERROR] drive.google.com IP mistmatch: 64.233.163.194 64.233.161.194
```

