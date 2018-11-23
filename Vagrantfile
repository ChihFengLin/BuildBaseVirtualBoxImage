# -*- mode: ruby -*-
# vi: set ft=ruby :

require "ipaddr"

PRIVATE_KEY_SOURCE        = '~/.vagrant.d/insecure_private_key'
PRIVATE_KEY_DESTINATION   = '/home/vagrant/.ssh/id_rsa'
MGMNT_IP_ADDR             = IPAddr.new("192.168.100.2")
MGMNT_IP                  = MGMNT_IP_ADDR.to_string
NUM_WORKERS               = ENV['num_workers']
BOX_NAME                  = ENV['box_name']
MASTER_IP_ADDR            = MGMNT_IP_ADDR.succ
MASTER_IP                 = MASTER_IP_ADDR.to_string

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.ssh.username   = 'vagrant'
  config.ssh.password   = 'vagrant'

  # define vip_master box
  config.vm.define "vip_master" do |vip_master|
    vip_master.vm.hostname = "vip-master"
    vip_master.vm.box = BOX_NAME
    vip_master.vm.synced_folder '.', '/vagrant', disabled: true
    vip_master.vm.network "private_network", ip: "#{MASTER_IP}"
    vip_master.vm.provider "virtualbox" do |v|
      v.name = "vip_master"
      v.cpus = 1
      v.memory = 5120
    end
    vip_master.vm.provision :file do |file|
      file.source      = PRIVATE_KEY_SOURCE
      file.destination = PRIVATE_KEY_DESTINATION
    end
    vip_master.vm.provision "shell", path: "boot/bootstrap-vip_common.sh", args: "#{MGMNT_IP} #{NUM_WORKERS}"
  end

  ip_addr = MASTER_IP_ADDR
  NUM_WORKERS.to_i.times do |i|
    # define vip_worker box
    config.vm.define "vip_worker#{i}" do |vip_worker|
      ip_addr = ip_addr.succ
      vip_worker.vm.hostname = "vip-worker#{i}"
      vip_worker.vm.box = BOX_NAME
      vip_worker.vm.synced_folder '.', '/vagrant', disabled: true
      vip_worker.vm.network "private_network", ip: "#{ip_addr.to_string}"
      vip_worker.vm.provider "virtualbox" do |v|
        v.name = "vip_worker#{i}"
        v.cpus = 1
        v.memory = 2048
      end
      vip_worker.vm.provision :file do |file|
        file.source      = PRIVATE_KEY_SOURCE
        file.destination = PRIVATE_KEY_DESTINATION
      end
      vip_worker.vm.provision "shell", path: "boot/bootstrap-vip_common.sh", args: "#{MGMNT_IP} #{NUM_WORKERS}"
    end
  end

  # define vip_mgmnt box
  config.vm.define "vip_mgmnt" do |vip_mgmnt|
    vip_mgmnt.vm.hostname = "vip-mgmnt"
    vip_mgmnt.vm.box = BOX_NAME
    vip_mgmnt.vm.synced_folder '.', '/vagrant', disabled: true
    vip_mgmnt.vm.network "private_network", ip: "#{MGMNT_IP}"
    vip_mgmnt.vm.provider "virtualbox" do |v|
      v.name = "vip_mgmnt"
      v.cpus = 1
      v.memory = 2048
    end
   # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
    vip_mgmnt.vm.provision :file do |file|
      file.source      = PRIVATE_KEY_SOURCE
      file.destination = PRIVATE_KEY_DESTINATION
    end
    vip_mgmnt.vm.provision "shell", path: "boot/bootstrap-vip_common.sh", args: "#{MGMNT_IP} #{NUM_WORKERS}"
    vip_mgmnt.vm.provision "shell", path: "boot/bootstrap-vip_mgmnt.sh"
  end

end
