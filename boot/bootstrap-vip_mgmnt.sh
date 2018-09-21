#!/bin/bash

chmod 600 /home/vagrant/.ssh/id_rsa

sudo yum -y update
sudo yum -y install epel-release || sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install gcc gcc-c++ python-virtualenv python-pip python-devel libffi-devel openssl-devel libyaml-devel sshpass git vim-enhanced

virtualenv ~/ansible; source ~/ansible/bin/activate

pip install --trusted-host files.pythonhosted.org setuptools --upgrade
pip install --trusted-host files.pythonhosted.org pip --upgrade
pip install --trusted-host files.pythonhosted.org pycparser functools32 pytz ansible==2.3.2
