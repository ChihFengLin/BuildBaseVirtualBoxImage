#!/bin/bash

chmod 600 /home/vagrant/.ssh/id_rsa

sudo yum -y update
sudo yum -y install epel-release || sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install gcc gcc-c++ python-virtualenv python-pip python-devel libffi-devel openssl-devel libyaml-devel sshpass git vim-enhanced

virtualenv ~/ansible; source ~/ansible/bin/activate

# Install Ansible
pip install setuptools --upgrade
pip install pip --upgrade
pip install pycparser functools32 pytz ansible==2.3.2

# Install Salt Master and Configure
sudo yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
sudo yum -y install salt-master
sudo systemctl enable salt-master.service
sudo systemctl start salt-master.service

sleep 30
sudo salt-key -A -y
