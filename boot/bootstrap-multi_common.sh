#!/bin/bash

# not quite full proof:
#  - does not avoid network,router and broadcast
#  - does not recognize subnet boundaries with CIDR mask
function incrIP()
{
    IP=$1
    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' `echo $IP | sed -e 's/\./ /g'`)
    NEXT_IP_HEX=$(printf %.8X `echo $(( 0x$IP_HEX + 1 ))`)
    NEXT_IP=$(printf '%d.%d.%d.%d\n' `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
    echo "$NEXT_IP"
}

host_name=`hostname -f`
mgmnt_ip=$1
num_workers=$2
ssl_cert_file=$3


master_01_ip=$(incrIP $mgmnt_ip)
master_02_ip=$(incrIP $master_01_ip)

sudo sed -i "/$host_name/d" /etc/hosts

sudo sed -i "1s/^/$mgmnt_ip     vip-mgmnt	vip-mgmnt\n/"   /etc/hosts
sudo sed -i "1s/^/$master_01_ip    vip-master-01  vip-master-01\n/"  /etc/hosts
sudo sed -i "1s/^/$master_02_ip    vip-master-02  vip-master-02\n/"  /etc/hosts

worker_ip=$(incrIP $master_02_ip)
end_number=`expr $num_workers - 1`
for w in `seq 0 $end_number`;
do
    sudo sed -i "1s/^/$worker_ip    vip-worker$w    vip-worker$w\n/" /etc/hosts
    worker_ip=$(incrIP $worker_ip)
done


# Install Open JDK8 for each Node
sudo yum install -y java-1.8.0-openjdk-devel
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/profile
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /root/.bashrc

# Install Salt Minion
sudo yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm 
sudo yum -y install salt-minion

sed -i "16s/^/master: $mgmnt_ip\n/" /etc/salt/minion
sudo systemctl enable salt-minion.service
sudo systemctl start salt-minion.service
