# Bake Base Box (RHEL 7)

## Prerequisites
 * [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)  
 * [Packer](https://www.packer.io)  
 * [Vagrant](https://www.vagrantup.com)

## Steps
 
 * Setup [RedHat Developer Subscription](https://access.redhat.com) if one doesn't exist
 * [Download](https://developers.redhat.com/products/rhel/download/) RHEL-7.4 ISO to `iso/`
 * Export RedHat subscription credentials
 ```
 $ export RHSM_USERNAME="username"
 $ export RHSM_PASSWORD="password"
 ```
 * Run the bake script
 ```
 $ ./bake_vagrant_base_box.sh
 ```
 
 * Finally, it will generate the baked box under `boxes/` directory and add box into Vagrant as well

