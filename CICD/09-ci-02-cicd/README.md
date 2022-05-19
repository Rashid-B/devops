# Домашнее задание к занятию "09.02 CI\CD"

## Знакомоство с SonarQube

### Подготовка к выполнению

1. Выполняем `docker pull sonarqube:8.7-community`

2. Выполняем `docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:8.7-community`

3. Ждём запуск, смотрим логи через `docker logs -f sonarqube`

4. Проверяем готовность сервиса через [браузер](http://localhost:9000)

   [SonarQube]: https://photos.app.goo.gl/2WV51EX1ufbbRekA6

5. Заходим под admin\admin, меняем пароль на свой

В целом, в [этой статье](https://docs.sonarqube.org/latest/setup/install-server/) описаны все варианты установки, включая и docker, но так как нам он нужен разово, то достаточно того набора действий, который я указал выше.

### Основная часть

1. Создаём новый проект, название произвольное

   Есть предупреждение, что используется встроенная база данных. ЕЕ нельзя перенести и масшитабировать. Необходимо добавить PostgreSQL в качестве базы данных. 

2. Скачиваем пакет sonar-scanner, который нам предлагает скачать сам sonarqube

   Ссылка ведет на локальный адрес http://localhost:9000/, требуется установить с официального сайта.

3. Делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)

   Сделал через символьную ссылку на файл

   `ioi@ioi-Pro:~$ sudo ln -s /home/ioi/DevOps/CICD/09-ci-02-cicd/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner`
   `ioi@ioi-Pro:~$ sudo ln -s /home/ioi/DevOps/CICD/09-ci-02-cicd/sonar-scanner/bin/sonar-scanner-debug /usr/bin/sonar-scanner-debug`

4. Проверяем `sonar-scanner --version`

   `ioi@ioi-Pro:~$ sonar-scanner --version`
   `INFO: Scanner configuration file: /home/ioi/DevOps/CICD/09-ci-02-cicd/sonar-scanner/conf/sonar-scanner.properties`
   `INFO: Project root configuration file: NONE`
   `INFO: SonarScanner 4.7.0.2747`
   `INFO: Java 11.0.14.1 Eclipse Adoptium (64-bit)`
   `INFO: Linux 5.13.0-40-generic amd64`

5. Запускаем анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`

6. Смотрим результат в интерфейсе

   [Status]: https://photos.app.goo.gl/yrKDTwq5G68wt7ki8

7. Исправляем ошибки, которые он выявил(включая warnings)

8. Запускаем анализатор повторно - проверяем, что QG пройдены успешно

9. Делаем скриншот успешного прохождения анализа, прикладываем к решению ДЗ

   [Результат]: https://photos.app.goo.gl/xmgHrQNa4DyyamAr8
   
   

## Знакомство с Nexus

### Подготовка к выполнению

1. Выполняем `docker pull sonatype/nexus3`

2. Выполняем `docker run -d -p 8081:8081 --name nexus sonatype/nexus3`

3. Ждём запуск, смотрим логи через `docker logs -f nexus`

4. Проверяем готовность сервиса через [бразуер](http://localhost:8081)

5. Узнаём пароль от admin через `docker exec -it nexus /bin/bash`

   `ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd$ docker exec -it nexus /bin/bash`
   `bash-4.4$ cat nexus-data/admin.password`
   `69dadf06-87da-4d91-83d0-2715909e5455`

6. Подключаемся под админом, меняем пароль, сохраняем анонимный доступ

### Основная часть

1. В репозиторий `maven-public` загружаем артефакт с GAV параметрами:
   1. groupId: netology
   2. artifactId: java
   3. version: 8_282
   4. classifier: distrib
   5. type: tar.gz
   
2. В него же загружаем такой же артефакт, но с version: 8_102

3. Проверяем, что все файлы загрузились успешно

4. В ответе присылаем файл `maven-metadata.xml` для этого артефекта

   [Итог]: https://photos.app.goo.gl/7yWxCRBabUz5i8n36

   

### Знакомство с Maven

### Подготовка к выполнению

1. Скачиваем дистрибутив с [maven](https://maven.apache.org/download.cgi)

2. Разархивируем, делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)

3. Проверяем `mvn --version`

   `ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd$ sudo ln -s /home/ioi/DevOps/CICD/09-ci-02-cicd/apache-maven/bin/mvn /usr/bin/mvn
   [sudo] пароль для ioi: 
   ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd$ chmod ugo+x /usr/bin/mvn
   ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd$ mvn --version
   Apache Maven 3.8.5 (3599d3414f046de2324203b78ddcf9b5e4388aa0)
   Maven home: /home/ioi/DevOps/CICD/09-ci-02-cicd/apache-maven
   Java version: 17.0.2, vendor: Oracle Corporation, runtime: /home/ioi/DevOps/java/jdk-17.0.2
   Default locale: ru_RU, platform encoding: UTF-8
   OS name: "linux", version: "5.13.0-40-generic", arch: "amd64", family: "unix"
   ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd$ `

4. Забираем директорию [mvn](./mvn) с pom

### Основная часть

1. Меняем в `pom.xml` блок с зависимостями под наш артефакт из первого пункта задания для Nexus (java с версией 8_282)

2. Запускаем команду `mvn package` в директории с `pom.xml`, ожидаем успешного окончания

   ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd/mvn$ mvn package
   [INFO] Scanning for projects...
   [INFO] 
   [INFO] --------------------< com.netology.app:simple-app >---------------------
   [INFO] Building simple-app 1.0-SNAPSHOT
   [INFO] --------------------------------[ jar ]---------------------------------
   Downloading from my-repo: http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282.pom
   [WARNING] Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de from my-repo for http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282.pom
   [WARNING] Could not validate integrity of download from http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282.pom
   org.eclipse.aether.transfer.ChecksumFailureException: Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de
       at org.eclipse.aether.connector.basic.ChecksumValidator.validateExternalChecksums (ChecksumValidator.java:174)
       at org.eclipse.aether.connector.basic.ChecksumValidator.validate (ChecksumValidator.java:103)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$GetTaskRunner.runTask (BasicRepositoryConnector.java:460)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$TaskRunner.run (BasicRepositoryConnector.java:364)
       at org.eclipse.aether.util.concurrency.RunnableErrorForwarder$1.run (RunnableErrorForwarder.java:75)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$DirectExecutor.execute (BasicRepositoryConnector.java:628)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector.get (BasicRepositoryConnector.java:262)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.performDownloads (DefaultArtifactResolver.java:514)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.resolve (DefaultArtifactResolver.java:402)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.resolveArtifacts (DefaultArtifactResolver.java:229)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.resolveArtifact (DefaultArtifactResolver.java:207)
       at org.apache.maven.repository.internal.DefaultArtifactDescriptorReader.loadPom (DefaultArtifactDescriptorReader.java:240)
       at org.apache.maven.repository.internal.DefaultArtifactDescriptorReader.readArtifactDescriptor (DefaultArtifactDescriptorReader.java:171)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.resolveCachedArtifactDescriptor (DefaultDependencyCollector.java:538)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.getArtifactDescriptorResult (DefaultDependencyCollector.java:523)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.processDependency (DefaultDependencyCollector.java:410)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.processDependency (DefaultDependencyCollector.java:362)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.process (DefaultDependencyCollector.java:349)
       at org.eclipse.aether.internal.impl.collect.DefaultDependencyCollector.collectDependencies (DefaultDependencyCollector.java:254)
       at org.eclipse.aether.internal.impl.DefaultRepositorySystem.collectDependencies (DefaultRepositorySystem.java:284)
       at org.apache.maven.project.DefaultProjectDependenciesResolver.resolve (DefaultProjectDependenciesResolver.java:170)
       at org.apache.maven.lifecycle.internal.LifecycleDependencyResolver.getDependencies (LifecycleDependencyResolver.java:243)
       at org.apache.maven.lifecycle.internal.LifecycleDependencyResolver.resolveProjectDependencies (LifecycleDependencyResolver.java:147)
       at org.apache.maven.lifecycle.internal.MojoExecutor.ensureDependenciesAreResolved (MojoExecutor.java:339)
       at org.apache.maven.lifecycle.internal.MojoExecutor.doExecute (MojoExecutor.java:293)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:211)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:165)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:157)
       at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject (LifecycleModuleBuilder.java:121)
       at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject (LifecycleModuleBuilder.java:81)
       at org.apache.maven.lifecycle.internal.builder.singlethreaded.SingleThreadedBuilder.build (SingleThreadedBuilder.java:56)
       at org.apache.maven.lifecycle.internal.LifecycleStarter.execute (LifecycleStarter.java:127)
       at org.apache.maven.DefaultMaven.doExecute (DefaultMaven.java:294)
       at org.apache.maven.DefaultMaven.doExecute (DefaultMaven.java:192)
       at org.apache.maven.DefaultMaven.execute (DefaultMaven.java:105)
       at org.apache.maven.cli.MavenCli.execute (MavenCli.java:960)
       at org.apache.maven.cli.MavenCli.doMain (MavenCli.java:293)
       at org.apache.maven.cli.MavenCli.main (MavenCli.java:196)
       at jdk.internal.reflect.NativeMethodAccessorImpl.invoke0 (Native Method)
       at jdk.internal.reflect.NativeMethodAccessorImpl.invoke (NativeMethodAccessorImpl.java:77)
       at jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke (DelegatingMethodAccessorImpl.java:43)
       at java.lang.reflect.Method.invoke (Method.java:568)
       at org.codehaus.plexus.classworlds.launcher.Launcher.launchEnhanced (Launcher.java:282)
       at org.codehaus.plexus.classworlds.launcher.Launcher.launch (Launcher.java:225)
       at org.codehaus.plexus.classworlds.launcher.Launcher.mainWithExitCode (Launcher.java:406)
       at org.codehaus.plexus.classworlds.launcher.Launcher.main (Launcher.java:347)
   [WARNING] Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de from my-repo for http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282.pom
   Downloaded from my-repo: http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282.pom (7.9 kB at 59 kB/s)
   [WARNING] The POM for netology:java:tar.gz:distrib:8_282 is invalid, transitive dependencies (if any) will not be available, enable debug logging for more details
   Downloading from my-repo: http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
   [WARNING] Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de from my-repo for http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
   [WARNING] Could not validate integrity of download from http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
   org.eclipse.aether.transfer.ChecksumFailureException: Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de
       at org.eclipse.aether.connector.basic.ChecksumValidator.validateExternalChecksums (ChecksumValidator.java:174)
       at org.eclipse.aether.connector.basic.ChecksumValidator.validate (ChecksumValidator.java:103)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$GetTaskRunner.runTask (BasicRepositoryConnector.java:460)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$TaskRunner.run (BasicRepositoryConnector.java:364)
       at org.eclipse.aether.util.concurrency.RunnableErrorForwarder$1.run (RunnableErrorForwarder.java:75)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector$DirectExecutor.execute (BasicRepositoryConnector.java:628)
       at org.eclipse.aether.connector.basic.BasicRepositoryConnector.get (BasicRepositoryConnector.java:262)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.performDownloads (DefaultArtifactResolver.java:514)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.resolve (DefaultArtifactResolver.java:402)
       at org.eclipse.aether.internal.impl.DefaultArtifactResolver.resolveArtifacts (DefaultArtifactResolver.java:229)
       at org.eclipse.aether.internal.impl.DefaultRepositorySystem.resolveDependencies (DefaultRepositorySystem.java:340)
       at org.apache.maven.project.DefaultProjectDependenciesResolver.resolve (DefaultProjectDependenciesResolver.java:207)
       at org.apache.maven.lifecycle.internal.LifecycleDependencyResolver.getDependencies (LifecycleDependencyResolver.java:243)
       at org.apache.maven.lifecycle.internal.LifecycleDependencyResolver.resolveProjectDependencies (LifecycleDependencyResolver.java:147)
       at org.apache.maven.lifecycle.internal.MojoExecutor.ensureDependenciesAreResolved (MojoExecutor.java:339)
       at org.apache.maven.lifecycle.internal.MojoExecutor.doExecute (MojoExecutor.java:293)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:211)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:165)
       at org.apache.maven.lifecycle.internal.MojoExecutor.execute (MojoExecutor.java:157)
       at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject (LifecycleModuleBuilder.java:121)
       at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject (LifecycleModuleBuilder.java:81)
       at org.apache.maven.lifecycle.internal.builder.singlethreaded.SingleThreadedBuilder.build (SingleThreadedBuilder.java:56)
       at org.apache.maven.lifecycle.internal.LifecycleStarter.execute (LifecycleStarter.java:127)
       at org.apache.maven.DefaultMaven.doExecute (DefaultMaven.java:294)
       at org.apache.maven.DefaultMaven.doExecute (DefaultMaven.java:192)
       at org.apache.maven.DefaultMaven.execute (DefaultMaven.java:105)
       at org.apache.maven.cli.MavenCli.execute (MavenCli.java:960)
       at org.apache.maven.cli.MavenCli.doMain (MavenCli.java:293)
       at org.apache.maven.cli.MavenCli.main (MavenCli.java:196)
       at jdk.internal.reflect.NativeMethodAccessorImpl.invoke0 (Native Method)
       at jdk.internal.reflect.NativeMethodAccessorImpl.invoke (NativeMethodAccessorImpl.java:77)
       at jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke (DelegatingMethodAccessorImpl.java:43)
       at java.lang.reflect.Method.invoke (Method.java:568)
       at org.codehaus.plexus.classworlds.launcher.Launcher.launchEnhanced (Launcher.java:282)
       at org.codehaus.plexus.classworlds.launcher.Launcher.launch (Launcher.java:225)
       at org.codehaus.plexus.classworlds.launcher.Launcher.mainWithExitCode (Launcher.java:406)
       at org.codehaus.plexus.classworlds.launcher.Launcher.main (Launcher.java:347)
   [WARNING] Checksum validation failed, expected <!DOCTYPE but is 22540da6d5b3c1b400f491eee6c795a0d49c18de from my-repo for http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
   Downloaded from my-repo: http://localhost:8081/#browse/browse:maven-public/netology/java/8_282/java-8_282-distrib.tar.gz (7.9 kB at 102 kB/s)
   [INFO] 
   [INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ simple-app ---
   [WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
   [INFO] skip non existing resourceDirectory /home/ioi/DevOps/CICD/09-ci-02-cicd/mvn/src/main/resources
   [INFO] 
   [INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ simple-app ---
   [INFO] No sources to compile
   [INFO] 
   [INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ simple-app ---
   [WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
   [INFO] skip non existing resourceDirectory /home/ioi/DevOps/CICD/09-ci-02-cicd/mvn/src/test/resources
   [INFO] 
   [INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ simple-app ---
   [INFO] No sources to compile
   [INFO] 
   [INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ simple-app ---
   [INFO] No tests to run.
   [INFO] 
   [INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ simple-app ---
   [WARNING] JAR will be empty - no content was marked for inclusion!
   [INFO] Building jar: /home/ioi/DevOps/CICD/09-ci-02-cicd/mvn/target/simple-app-1.0-SNAPSHOT.jar
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  1.160 s
   [INFO] Finished at: 2022-05-19T16:22:38+03:00
   [INFO] ------------------------------------------------------------------------
   ioi@ioi-Pro:~/DevOps/CICD/09-ci-02-cicd/mvn$ ls -la ~/.m2/repository/netology/java/8_282/
   итого 52
   drwxrwxr-x 2 ioi ioi 4096 мая 19 16:22 .
   drwxrwxr-x 3 ioi ioi 4096 мая 19 16:18 ..
   -rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282-distrib.tar.gz
   -rw-rw-r-- 1 ioi ioi  463 мая 19 16:22 java-8_282-distrib.tar.gz.lastUpdated
   -rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282-distrib.tar.gz.sha1
   -rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282.pom
   -rw-rw-r-- 1 ioi ioi  803 мая 19 16:22 java-8_282.pom.lastUpdated
   -rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282.pom.sha1
   -rw-rw-r-- 1 ioi ioi  199 мая 19 16:22 _remote.repositories

3. Проверяем директорию `~/.m2/repository/`, находим наш артефакт

   `ioi@ioi-Pro:~$ ll ~/.m2/repository/netology/java/8_282/`
   `итого 52`
   `drwxrwxr-x 2 ioi ioi 4096 мая 19 16:22 ./`
   `drwxrwxr-x 3 ioi ioi 4096 мая 19 16:18 ../`
   `-rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282-distrib.tar.gz`
   `-rw-rw-r-- 1 ioi ioi  463 мая 19 16:22 java-8_282-distrib.tar.gz.lastUpdated`
   `-rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282-distrib.tar.gz.sha1`
   `-rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282.pom`
   `-rw-rw-r-- 1 ioi ioi  803 мая 19 16:22 java-8_282.pom.lastUpdated`
   `-rw-rw-r-- 1 ioi ioi 7925 мая 19 16:22 java-8_282.pom.sha1`
   `-rw-rw-r-- 1 ioi ioi  199 мая 19 16:22 _remote.repositories`

   

4. В ответе присылаем исправленный файл `pom.xml`

   

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---