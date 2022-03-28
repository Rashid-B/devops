## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
  - Инфраструктура развертываемая с помощью IaaC повторяема, отсутствует дрейф конфигурации
  - Скорость развертывания инфраструктуры
  - IaaC позволяетотслеживать каждое изменение конфигурации. Можно откатиться к последней работоспособной версии
  - Возможности автоматизации
- Какой из принципов IaaC является основополагающим?
  - Идемпотентность. Многократное выполнение приводит к одному и тому же результату.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
  - Управление узлами Ansible осуществляется по стандартному SSH
  - Лёгкая установка и настройка
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
  - push-подход  завязан на CD-систему и соответственно все изменения будут отражены в репозитории



## Задача 3

Установить на личный компьютер:

- VirtualBox

  ```
  rashid@rashid-NBD:~$ virtualbox -help
  Oracle VM VirtualBox VM Selector v6.1.32
  (C) 2005-2022 Oracle Corporation
  All rights reserved.
  
  No special options.
  
  If you are looking for --startvm and related options, you need to use VirtualBoxVM.
  ```


- Vagrant

  ```
  rashid@rashid-NBD:~$ vagrant --version
  Vagrant 2.2.6
  ```

- Ansible

  ```
  rashid@rashid-NBD:~$ ansible --version
  ansible 2.9.6
    config file = /etc/ansible/ansible.cfg
    configured module search path = ['/home/rashid/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
    ansible python module location = /usr/lib/python3/dist-packages/ansible
    executable location = /usr/bin/ansible
    python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]
  ```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.

  Пришлось заменить 

  ```
  node.vm.network "private_network", ip: machine[:ip]
  ```

  на 

  ```
  node.vm.network "public_network", ip: machine[:ip]
  ```

  Однако при выполнении не удалось записать ключи. 

  ```
  TASK [Adding rsa-key in /root/.ssh/authorized_keys]
  ```

  

  ```
  rashid@rashid-NBD:~/SandBox/vagrant$ vagrant up
  Bringing machine 'server1.netology' up with 'virtualbox' provider...
  ==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
  ==> server1.netology: Matching MAC address for NAT networking...
  ==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202112.19.0' is up to date...
  ==> server1.netology: Setting the name of the VM: server1.netology
  ==> server1.netology: Clearing any previously set network interfaces...
  ==> server1.netology: Preparing network interfaces based on configuration...
      server1.netology: Adapter 1: nat
      server1.netology: Adapter 2: bridged
  ==> server1.netology: Forwarding ports...
      server1.netology: 22 (guest) => 20011 (host) (adapter 1)
      server1.netology: 22 (guest) => 2222 (host) (adapter 1)
  ==> server1.netology: Running 'pre-boot' VM customizations...
  ==> server1.netology: Booting VM...
  ==> server1.netology: Waiting for machine to boot. This may take a few minutes...
      server1.netology: SSH address: 127.0.0.1:2222
      server1.netology: SSH username: vagrant
      server1.netology: SSH auth method: private key
      server1.netology: 
      server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
      server1.netology: this with a newly generated keypair for better security.
      server1.netology: 
      server1.netology: Inserting generated public key within guest...
      server1.netology: Removing insecure key from the guest if it's present...
      server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
  ==> server1.netology: Machine booted and ready!
  ==> server1.netology: Checking for guest additions in VM...
  ==> server1.netology: Setting hostname...
  ==> server1.netology: Configuring and enabling network interfaces...
  ==> server1.netology: Mounting shared folders...
      server1.netology: /vagrant => /home/rashid/SandBox/vagrant
  ==> server1.netology: Running provisioner: ansible...
  Vagrant has automatically selected the compatibility mode '2.0'
  according to the Ansible version installed (2.9.6).
  
  Alternatively, the compatibility mode can be specified in your Vagrantfile:
  https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode
  
      server1.netology: Running ansible-playbook...
  
  PLAY [nodes] *******************************************************************
  
  TASK [Gathering Facts] *********************************************************
  ok: [server1.netology]
  
  TASK [Create directory for ssh-keys] *******************************************
  ok: [server1.netology]
  
  TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
  An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
  fatal: [server1.netology]: FAILED! => {"changed": false, "msg": "Could not find or access '~/.ssh/id_rsa.pub' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
  ...ignoring
  
  TASK [Checking DNS] ************************************************************
  changed: [server1.netology]
  
  TASK [Installing tools] ********************************************************
  ok: [server1.netology] => (item=['git', 'curl'])
  
  TASK [Installing docker] *******************************************************
  changed: [server1.netology]
  
  TASK [Add the current user to docker group] ************************************
  changed: [server1.netology]
  
  PLAY RECAP *********************************************************************
  server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   
  
  rashid@rashid-NBD:~/SandBox/vagrant$ vagrant ssh
  Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)
  
   * Documentation:  https://help.ubuntu.com
   * Management:     https://landscape.canonical.com
   * Support:        https://ubuntu.com/advantage
  
    System information as of Sun 23 Jan 2022 08:41:52 PM UTC
  
    System load:  0.6                Users logged in:          0
    Usage of /:   13.4% of 30.88GB   IPv4 address for docker0: 172.17.0.1
    Memory usage: 24%                IPv4 address for eth0:    10.0.2.15
    Swap usage:   0%                 IPv4 address for eth1:    192.168.192.11
    Processes:    115
  
  This system is built by the Bento project by Chef Software
  More information can be found at https://github.com/chef/bento
  Last login: Sun Jan 23 20:40:47 2022 from 10.0.2.2
  vagrant@server1:~$ docker ps
  CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
  ```

  

- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

```
docker ps
```

```
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

