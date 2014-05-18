# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  config.vm.network "public_network", ip: "192.168.100.79", netmask: "255.255.255.0", bridge:
  config.vm.hostname = "localhost"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
  end

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.run_list = ["recipe[yum-epel::default]",
                     "recipe[passenger::yum-update]",
                     "recipe[ruby::rbenv]",
                     "recipe[passenger]",
                     "recipe[ruby::rails]",
                     "recipe[mysql::server]",
                     "recipe[redmine::mysql]",
                     "recipe[redmine]"]
  end

end
