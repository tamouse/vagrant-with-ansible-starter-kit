# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'resolv'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu1404"
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  # This is cool. In the host machine's /etc/hosts file, add the
  # following machine name with a local IP address of some sort.
  # (e.g. 192.168.33.33):
  #
  # 192.168.33.33	ubu14042.pontiki.dev ubu14042
  config.vm.network "private_network", ip: Resolv.getaddress("ubu14042.pontiki.dev") || "192.168.33.33"
  #
  # This probably doens't matter that much, but I like the hostname
  # and the machine network name from above to match.
  config.vm.hostname = 'ubu14042'


  # These settings are pretty good for doing Rails development. Bump them if you have a pretty
  # capable machine.
  config.vm.provider "virtualbox" do |vm|
    vm.customize ["modifyvm", :id, "--memory", "2048"] # 4096 on a heavy duty box is good
    vm.customize ["modifyvm", :id, "--vram", "12"]     # This gives enough to run x if you need to (e.g. xvfb)
    vm.customize ["modifyvm", :id, "--cpus", "2"]      # Bump to 4 on a super multicore machine (these are cores)
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # to use that nifty Resolve thing above
  end

  # so you can use your host user's keys on github, mainly
  config.ssh.forward_agent = true

  # Ansible is super easy to learn and provision a machine
  config.vm.provision "ansible" do |a|
    a.playbook = 'provisioning/playbook.yml'
  end
end
