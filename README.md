
[Unit]

    Description=MyUnit
    After=syslog.target
    After=network.target
    After=nginx.service
    After=mysql.service
    Requires=mysql.service
    Wants=redis.service

[Service]

    Type=forking
    PIDFile=/work/www/myunit/shared/tmp/pids/service.pid
    WorkingDirectory=/work/www/myunit/current

    EnvironmentFile=/work/www/myunit/shared/conf

    OOMScoreAdjust=-1000

    ExecStart=/usr/local/bin/bundle exec service -C ${test} --daemon
    ExecStop=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state stop
    ExecReload=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state restart
    TimeoutSec=300

[Install]
    
    WantedBy=multi-user.target 



2. CPU:     
           
        node_cpu_seconds_total{cpu="0",mode="idle"} 
   		node_cpu_seconds_total{cpu="0",mode="system"} 
   		node_cpu_seconds_total{cpu="0",mode="user"} 
   		process_cpu_seconds_total
   Memory:
    
       node_memory_MemAvailable_bytes 
       node_memory_MemFree_bytes

   Disk:
   
       node_disk_io_time_seconds_total{device="sda"} 
       node_disk_read_bytes_total{device="sda"} 
       node_disk_read_time_seconds_total{device="sda"} 
       node_disk_write_time_seconds_total{device="sda"}

   Network:
   
       node_network_receive_errs_total{device="eth0"} 
       node_network_receive_bytes_total{device="eth0"} 
       node_network_transmit_bytes_total{device="eth0"}
       node_network_transmit_errs_total{device="eth0"}

  3. 
         
         ![img_2](https://github.com/Rashid-B/devops/blob/fix/img_2.png)

  4. 
  
         Да можно  
         dmesg | grep CPU
         [    0.008948] CPU MTRRs all blank - virtualized system.

   5. 
  
    sysctl fs.nr_open
    fs.nr_open = 1048576
    максимальное количество открытых файлов
    ulimit -Sn и ulimit -Hn
    Покажет текущие "мягкие" и (второй вызов) "жесткие" ограничения
    При помощи ulimit можно открутить мягкие ограничения до пределов жестких

   6. 
    
     ps aux | grep sleep
     root           1  0.0  0.0   8076   592 ?        S    08:21   0:00 /usr/bin/sleep 1h
     root          73  0.0  0.0   8900   736 ?        S    08:40   0:00 grep sleep
     sudo nsenter -t 1 -m -p
     ps
       PID TTY          TIME CMD
         1 ?        00:00:00 sleep
        13 ?        00:00:00 bash
        19 ?        00:00:00 nsenter
        20 ?        00:00:00 bash
        26 ?        00:00:00 nsenter
        27 ?        00:00:00 bash
        32 ?        00:00:00 nsenter
        33 ?        00:00:00 bash
        42 ?        00:00:00 bash
        61 ?        00:00:00 bash
        64 ?        00:00:00 nsenter
        65 ?        00:00:00 bash
        87 ?        00:00:00 sudo
        88 ?        00:00:00 bash
        91 ?        00:00:00 sudo
        92 ?        00:00:00 nsenter
        93 ?        00:00:00 bash
       108 ?        00:00:00 sudo
       109 ?        00:00:00 nsenter
       110 ?        00:00:00 bash
       113 ?        00:00:00 ps

   7. 
    
     определяет функцию с именем : , которая порождает саму себя (дважды, один канал переходит в другой)
     В системе есть ограничения на ресурсы, при превышении которых система начинает блокировать создание новых процессов.
     [ 4055.557674] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-8.scope
     ulimit для ограничения количества processes-per-user:
