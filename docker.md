# Docker notes

## Installing docker on Ubuntu 18

Source: https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04

```
sudo apt install docker.io
sudo apt install docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $USER
```

Log out and log in

Voila!

## Docker disc usage

```
docker system df
```

## Restart docker

```
sudo service docker stop
sudo service docker start
sudo service docker restart
```

## Check docker version

```
docker --version   ## short info
docker version     ## full info
docker info
```

## Port already in use solution

If the postgres deamon is already running, there might be a conflict

```
sudo lsof -i -P -n | grep 5432
sudo kill <process-id>
```
