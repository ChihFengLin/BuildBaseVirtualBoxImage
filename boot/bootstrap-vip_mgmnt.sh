#!/bin/bash

python3 -m venv ~/ansible; source ~/ansible/bin/activate

# Install Ansible
pip install setuptools --upgrade
pip install pip --upgrade
pip install ansible==4.0.0

# Install Salt Master and Configure
sudo yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
sudo yum -y install salt-master
sudo systemctl enable salt-master.service
sudo systemctl start salt-master.service

sleep 30
sudo salt-key -A -y
