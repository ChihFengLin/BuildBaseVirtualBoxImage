# Local Dev Environment Setup

## 1. Bake Base Box (RHEL 7)

## Prerequisites
 * [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)  
 * [Packer](https://www.packer.io)  
 * [Vagrant](https://www.vagrantup.com)

## Steps
 
 1. Setup [RedHat Developer Subscription](https://access.redhat.com) if one doesn't exist
 2. [Download](https://developers.redhat.com/products/rhel/download/) RHEL-7.5 ISO to `iso/`
 3. Export RedHat subscription credentials
 ```
 $ export RHSM_USERNAME="username"
 $ export RHSM_PASSWORD="password"
 ```
 4. Run the bake script
 ```
 $ ./bake_vagrant_base_box.sh
 ```
 
 5. Finally, it will generate the baked box under `boxes/` directory and add box into Vagrant as well

## 2. Launch Local Cluster Environment

 1. Launch multi-node VM cluster (1 management node, 1 master and n workers - starting with ip 192.168.100.2 (/24 CIDR))
 ```
 $ ./launch_local_cluster.sh --num_workers 1 --vagrant_box "base-rhel-7.5-vbox" --multi_master false
 ```
 - Ansible and Salt included in management node
