#!/bin/bash

set -e

echo "==============Installing Git==============="
sudo apt-get -y install git
sudo apt-get install -y build-essential libssl-dev

echo "===============Installing Go==============="
if [ ! -d "go" ]; then
     wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && sudo tar -C ~/ -xzvf go1.7.3.linux-amd64.tar.gz
fi

echo "===============Setting GOROOT and GOPATH==============="
if [ ! -f "/etc/profile.d/setting_gopath.sh" ]; then
     echo -e "export GOROOT=/home/$(whoami)/go\nexport GOPATH=/home/$(whoami)/gopath\nexport PATH=\$PATH:\$GOROOT/bin" | sudo tee -a /etc/profile.d/setting_gopath.sh
     source /etc/profile.d/setting_gopath.sh
fi

echo "===============Installing Docker==============="
sudo apt-get update 
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-ce
sudo usermod -aG docker $(whoami)
if [ "$(lsb_release -rs)" == "16.04" || "$(lsb_release -rs)" == "16.10" ]; then 
     sudo sed  -i 's/\(.* -H fd:\/\/\)\(.*\)/\1 -H tcp\:\/\/0.0.0.0\:2375 -H unix\:\/\/\/var\/run\/docker\.sock/' /lib/systemd/system/docker.service
     sudo systemctl restart docker.service
     sudo systemctl restart docker.socket
     sudo systemctl daemon-reload

elif [ "$(lsb_release -rs)" == "14.04" ]; then
     echo "DOCKER_OPTS=\"-s=aufs -r=true --api-cors-header='*' -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock \"" | sudo tee /etc/default/docker
fi
sudo service docker restart

echo "===============Installing NodeJS and NPM==============="
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install lts/boron

echo "===============Installing Docker-Compose==============="
sudo apt-get -y install curl
sudo curl -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "===============Installing PIP==============="
sudo apt-get -y install python-pip python-dev 
sudo pip install --upgrade pip 
