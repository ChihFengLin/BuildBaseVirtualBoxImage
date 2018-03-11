#!/bin/bash


sudo yum -y update
sudo yum -y install epel-release || sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install gcc gcc-c++ python-virtualenv python-pip python-devel libffi-devel openssl-devel libyaml-devel sshpass git vim-enhanced


pip install setuptools --upgrade
pip install --upgrade pip
pip install pycparser functools32 pytz ansible==2.3.2