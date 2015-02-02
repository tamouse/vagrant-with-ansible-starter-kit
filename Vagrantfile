# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'resolv'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty-server-cloudimg-amd64-vagrant-disk1"
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.hostname = 'ubu14-04-2'
  config.vm.network "private_network", ip: Resolv.getaddress("ubu14042.pontiki.dev")
  # config.vm.network "forwarded_port", guest: 22, host: 2200, auto_correct: true
  config.ssh.forward_agent = true

  config.vm.provision "ansible" do |a|
    a.playbook = 'provisioning/playbook.yml'
  end
end
