# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.ssh.username   = 'vagrant'
  config.ssh.password   = 'vagrant'

  config.vm.define "rhel" do |rhel|
    rhel.vm.hostname = "rhel-master"
    rhel.vm.box = "base-rhel-7.4-vbox"
    rhel.vm.synced_folder '.', '/vagrant', disabled: true
    rhel.vm.network "private_network", ip: "192.168.100.10"
    rhel.vm.provider "virtualbox" do |v|
      v.name = "rhel-master"
      v.cpus = 2
      v.memory = 3072
    end
    rhel.vm.provision "shell", path: "boot/bootstrap-script.sh"
  end

end