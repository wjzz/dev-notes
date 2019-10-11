# Installing docker on Ubuntu 18

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

## Restart docker

```
sudo service docker restart
```
