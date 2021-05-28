#!/bin/bash

python3 -m ven ~/ansible; source ~/ansible/bin/activate

# Install Ansible
pip install setuptools --upgrade
pip install pip --upgrade
pip install pycparser functools32 pytz ansible==4.0.0

# Install Salt Master and Configure
sudo yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
sudo yum -y install salt-master
sudo systemctl enable salt-master.service
sudo systemctl start salt-master.service

sleep 30
sudo salt-key -A -y
