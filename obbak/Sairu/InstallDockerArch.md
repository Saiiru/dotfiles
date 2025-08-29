**If you do not have `yay` installed, then follow [these steps](https://itsfoss.com/install-yay-arch-linux) to install it first**

## **Update**
```sh
yay
```

## **Install**
```sh
yay -S docker docker-compose
```

## **Start the service**
```sh
sudo systemctl start docker.service
```
**If the above command throws an error, then do the following**
```sh
sudo systemctl enable docker.service
reboot
```

## **Linux post-install step (to run `docker` without root or `sudo` one might say)**
```sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```