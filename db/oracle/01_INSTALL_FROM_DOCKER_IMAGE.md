# Installation of Oracle Database from Docker image

https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance

We install the only available Express Edition (18c XE):
```s
cd dockerfiles
./buildContainerImage.sh -x -v 18.4.0
```
Start: 13:27
End:   13:50

Build completed in 1516 seconds.

# Installation of SQL*plus from Docker image

https://github.com/oracle/docker-images/tree/main/OracleInstantClient

Use v21/oraclelinux8
```s
docker build -t sqlplus .
```

Run:
```s
docker run -it --rm sqlplus
```

# Access from the DB container

```s
docker exec -it oracle_db sqlplus sys/master@//localhost:1521/XE as sysdba
```

```s
ls /opt/oracle/oradata/XE/
```

Docker container's IP:
172.17.0.2
