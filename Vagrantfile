# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

# Using resolv allows us to set up a nice machine name on the host
# machine's `/etc/hosts` file to use in place of a raw IP address or
# to have to know ahead of time all the ports to forward to the host
# machine. We can browse to `http://jessie.local:3000` for example.
#
# To configure the `/etc/hosts` file to work with the values below,
# add a line as follows to `/etc/hosts`:
#
# 192.168.100.10	jessie.local
#
# Do make sure there are no other machines listed using that IP
# address, and choose one the rest of your network won't try to create
# as well.
#
# You can override these settings in your local environment as well,
# although that can be dangerous if you forget to set them.
require 'resolv'
BOX_NAME = ENV['BOX_NAME'] ||= 'jessie'
BOX_IP   = ENV['BOX_IP']   ||= '192.168.100.10'
BOX_URL  = ENV['BOX_URL']  ||= 'https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URL

  config.vm.network "private_network", ip: (Resolv.getaddress("#{BOX_NAME}.local") rescue BOX_IP)

  # This probably doens't matter that much, but I like the hostname
  # and the machine network name from above to match.
  config.vm.hostname = BOX_NAME

  # These settings are pretty good for doing Rails development. Bump them if you have a pretty
  # capable machine.
  config.vm.provider "virtualbox" do |vm|
    vm.customize ["modifyvm", :id, "--cpus",   "2"]               # Bump to 4 on a super multicore machine (these are cores)
    vm.customize ["modifyvm", :id, "--memory", "2048"]            # 4096 on a heavy duty box is good
    vm.customize ["modifyvm", :id, "--vram",   "12"]              # This gives enough to run x if you need to (e.g. xvfb)
    vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # to use that nifty Resolv thing above
  end

  # so you can use your host user's keys on github, mainly
  config.ssh.forward_agent = true

  # Ansible is super easy to learn and provision a machine
  config.vm.provision "ansible" do |a|
    a.playbook = 'provisioning/playbook.yml'
  end
end
