#!/bin/bash

INSTALL_DIR=/home/$USER/eDappinstall

echo "###########################################################################################"
echo "#                                Welcome to eDapp                                         #"
echo "###########################################################################################"

echo "########################################################"
echo "#                Installing Prerequisites              #"
echo "########################################################"
sudo apt-get update
sudo apt-get install python-dev python-pip libssl-dev libffi-dev -y
sudo pip install --upgrade pip
sudo pip install 'ansible>=2.3.0.0'
sudo pip install boto3 shade boto
sudo pip install --upgrade pyOpenSSL
echo "########################################################"
echo "#          Completed installing Prerequisites          #"
echo "########################################################"

echo "########################################################"
echo "#          Installing Application on AWS               #"
echo "########################################################"

export AWS_SECRET_KEY="2Oa7sUI1QmJ4yLLc9XdVq7pj5Voh12RLbdrGlx7L"
if [ ! -d "$INSTALL_DIR" ]; then
     cd ~ && git clone http://192.168.5.61:8080/eDappinstall
else
     cd $INSTALL_DIR
     git checkout -- ./ansible/vars/aws.yml
     git pull origin master
fi
cd $INSTALL_DIR/ansible
sed -i "s/ibmadmin/${USER}/g" ./vars/aws.yml
sudo ntpdate us.pool.ntp.org
ansible-playbook -i run/runhosts -e "mode=apply env=aws cloud_type=aws password=$AWS_SECRET_KEY" provcluster.yml
ansible-playbook -i run/runhosts -e "mode=apply env=aws deploy_type=compose" initcluster.yml --skip-tags="resetconn"
#ansible-playbook -i run/runhosts -e "mode=apply env=aws env_type=k8s" initcluster.yml --skip-tags="resetconn"
ansible-playbook -i run/runhosts -e "mode=apply env=bc1st target=configtxgen,cryptogen" setupfabric.yml
ansible-playbook -i run/runhosts -e "mode=apply env=bc1st app=procurement" application.yml
