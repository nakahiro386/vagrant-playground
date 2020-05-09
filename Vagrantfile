# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=755', 'fmode=755']
  config.vm.synced_folder "./.vagrant", "/home/vagrant/.vagrant", mount_options: ['dmode=777', 'fmode=600']
  config.ssh.forward_x11 = true   # export DISPLAY=10.0.2.2:0.0
  # plugin settings
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
    config.vbguest.no_install = true
    config.vbguest.installer_options = {allow_kernel_upgrade: true, reboot_timeout: 300}
  end
  config.timezone.value = 'Asia/Tokyo' if Vagrant.has_plugin?("vagrant-timezone")
  config.cache.scope = :box if Vagrant.has_plugin?("vagrant-cachier")
  # config.cache.disable!

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.linked_clone = true
    vb.default_nic_type = "virtio"
    vb.cpus = 2
    vb.memory = 1024 * 2
    vb.customize [
      "modifyvm", :id,
      "--chipset", "ich9",
      "--ioapic", "on",
      "--pae", "on",
      "--hwvirtex", "on",
      "--nestedpaging", "on",
      "--largepages", "on",
      "--audio", "none",
    ]
  end

  machines = YAML.load_file("#{File.dirname(__FILE__)}/machines.yml")
  machines.each do |m|
    name = m["name"]
    box = m["box"]
    memory = m["memory"]
    config.vm.define "#{name}" do |machine|
      machine.vm.box = box
      machine.vm.hostname = name
      machine.vm.provider "virtualbox" do |vb, override|
        vb.name = name
        vb.memory = memory if memory
      end
      machine.vm.provision "bootstrap", type: "shell", privileged: false, inline: <<-SHELL
        /bin/sh /vagrant/mitamae/bootstrap.sh
      SHELL
      machine.vm.provision "setup_sshkey", type: "shell", privileged: false, inline: <<-SHELL
        mkdir -p -m u=rwx,g=,o= ~/.ssh
        cp -f ~/.vagrant/machines/#{name}/virtualbox/private_key ~/.ssh/id_rsa
        chmod u=rw,g=,o= ~/.ssh/id_rsa
      SHELL
    end
  end

end
