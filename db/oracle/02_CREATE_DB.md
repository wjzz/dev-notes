```s
docker run --name oracle_db \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=master \
  -v /opt/oracle/oradata \
  oracle/database:18.4.0-xe
```
