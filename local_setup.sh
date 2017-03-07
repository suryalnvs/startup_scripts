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
if [ ! -f "/etc/profile.d/setup.sh" ]; then
     echo -e "export GOROOT=/home/$(whoami)/go\nexport GOPATH=/home/$(whoami)/gopath\nexport PATH=\$PATH:\$GOROOT/bin" | sudo tee -a /etc/profile.d/setup.sh
     source /etc/profile.d/setup.sh
fi

echo "===============Installing Docker==============="
sudo apt-get -y install apt-transport-https ca-certificates
sudo apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
     echo "deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/docker.list
fi
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install docker-engine
sudo usermod -aG docker $(whoami)
sudo sed  -i 's/\(.* -H fd:\/\/\)\(.*\)/\1 -H tcp\:\/\/0.0.0.0\:2375 -H unix\:\/\/\/var\/run\/docker\.sock/' /lib/systemd/system/docker.service
sudo systemctl restart docker.service
sudo systemctl restart docker.socket
sudo systemctl daemon-reload
sudo service docker restart

echo "===============Installing NodeJS and NPM==============="
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs

echo "===============Installing Docker-Compose==============="
sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "===============Installing PIP==============="
sudo apt-get install python-pip python-dev
sudo pip install --upgrade pip

echo "===============Installing Vagrant==============="
if [ ! -f "vagrant_1.9.2_x86_64.deb" ]; then
     wget https://releases.hashicorp.com/vagrant/1.9.2/vagrant_1.9.2_x86_64.deb && sudo dpkg -i vagrant_1.9.2_x86_64.deb
fi

echo "===============Installing Virtualbox==============="
if [ ! -f "virtualbox-5.1_5.1.14-112924~Ubuntu~$(lsb_release -cs)_amd64.deb" ]; then
     wget http://download.virtualbox.org/virtualbox/5.1.14/virtualbox-5.1_5.1.14-112924~Ubuntu~$(lsb_release -cs)_amd64.deb && sudo dpkg -i virtualbox-5.1_5.1.14-112924*.deb
fi

echo "===============Setting up Fabric environment==============="
if [ ! -d "$GOPATH/src/github.com" ]; then
     cd ~ && mkdir -p gopath/src/github.com/hyperledger
     if [ ! -d "$GOPATH/src/github.com/hyperledger/fabric" ]; then
          cd $GOPATH/src/github.com/hyperledger/ && git clone https://github.com/hyperledger/fabric.git
     fi
fi
cd fabric/devenv && vagrant up

