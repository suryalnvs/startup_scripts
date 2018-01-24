sudo apt-get update
sudo apt-get install python-dev python-pip libssl-dev libffi-dev -y
sudo pip install --upgrade pip
sudo pip install 'ansible>=2.3.0.0'
sudo pip install boto3 shade boto
sudo pip install --upgrade pyOpenSSL

#sed -i 's/ibmadmin/'"${whoami}"'/g' ./vars/aws.yml
export AWS_SECRET_KEY="2Oa7sUI1QmJ4yLLc9XdVq7pj5Voh12RLbdrGlx7L"
cd ~ && git clone http://192.168.5.61:8080/eDappinstall
cd ~/eDappinstall/ansible
sudo ntpdate us.pool.ntp.org
ansible-playbook -i run/runhosts -e "mode=apply env=aws cloud_type=aws" provcluster.yml
ansible-playbook -i run/runhosts -e "mode=apply env=aws deploy_type=compose" initcluster.yml --skip-tags="resetconn"
#ansible-playbook -i run/runhosts -e "mode=apply env=aws env_type=k8s" initcluster.yml --skip-tags="resetconn"
ansible-playbook -i run/runhosts -e "mode=apply env=bc1st target=configtxgen,cryptogen" setupfabric.yml
ansible-playbook -i run/runhosts -e "mode=apply env=bc1st app=procurement" application.yml
