# Local Dev Environment Setup

## 1. Bake Base Box (RHEL 7)

## Prerequisites
 * [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)  
 * [Packer](https://www.packer.io)  
 * [Vagrant](https://www.vagrantup.com)

## Steps
 
 1. [Download](https://www.centos.org/download/) CentOS 7 ISO to `iso/`
 2. Run the bake script
 ```
 $ ./bake_vagrant_base_box.sh
 ```
 3. Finally, it will generate the baked box under `boxes/` directory and add box into Vagrant as well

## 2. Launch Local Cluster Environment

 1. Launch multi-node VM cluster (1 management node, 1 master and n workers - starting with ip 192.168.100.2 (/24 CIDR))
 ```
 $ ./launch_local_cluster.sh --num_workers 1 --vagrant_box "base-centos-7-vbox" --multi_master false
 ```
 - Ansible and Salt included in management node
