# -*- mode: ruby -*-
# vi: set ft=ruby :

$install = <<SCRIPT
# install salt
/git/salt/bin/salt-install.sh

# create sym-links
ln -s /git/config/vagrant/etc/salt/grains /etc/salt/grains
ln -s /git/salt/salt /srv/salt

# add minion and state apply
/git/salt/bin/salt-local-accept.sh
/git/salt/bin/salt-local-state-apply.sh
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "jbsambiental"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/git"
  config.vm.network 'private_network', ip: '172.10.100.110'
  config.vm.provision "shell", inline: $install

  # resource config
  config.vm.provider "virtualbox" do |v, override|
       v.customize ["modifyvm", :id, "--cpus", "2"]
       v.customize ["modifyvm", :id, "--ioapic", "on"]
       v.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
       v.customize ["modifyvm", :id, "--memory", "3000"]
   end

end
