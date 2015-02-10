# vagrant-ubu14.04-emacs24-ruby-2.2.0-development
Basic vagrant setup for a development box.

## General

This is a pretty bog-standard development box that I use for
development on multiple projects. I keep all my projects under
`~/Projects` which is where I install the vagrant box. (`vagrant up`
looks up the directory tree until it encounters a `Vagrantfile` file,
and uses that to create the VM.)

## Prerequisites

1. Read the Vagrant docs if necessary <http://docs.vagrantup.com>
1. Install Vagrant and a provider (I use virtualbox).
2. Read the Ansible docs if you think you want to change the
   provisioning (add your own favourite packages, configurations, etc.)
2. Install Ansible.
3. There are probably others, but I can't be arsed to figure them all
   out. 

## Installation

Fork the repo on Github. Then clone your fork to where you want to
work from:

    $ mkdir -p /path/to/boxes
    $ cd /path/to/boxes
    $ git clone https://github.com/<your github account name>/vagrant-ubu14.04-emacs24-ruby-2.2.0-development.git dev
    $ cd dev

## Configurations

### Vagrantfile

The only thing that you should change in the `Vagrantfile` is the
machine name where it sets the IP address. I'm using the `resolv` Ruby
Standard Library package to find a machine name from the `/etc/hosts`
file. My `hosts` file contains a line like this:

```
192.168.35.11	ubu14042.pontiki.dev
```

The line in the `Vagrantfile` that matches this is:

``` ruby
config.vm.network "private_network", ip: Resolv.getaddress("ubu14042.pontiki.dev")
```
  
You should make sure these match your expectations.

I do it this way instead of using forwarded ports, but of course you
can do it that way if you want.

#### Provider configuration

I use virtualbox, and have set up the virtual machine "hardware"
configuration for the VboxManage tool. Current settings include:

* Memory (RAM): 2048M (2G)
* CPUs (cores): 2
* VRAM: 12M
* NAT DNS Host Resolver 1: ON (in order to use the niftiness of Resolv
  above)

If you're planning on doing some heavy-duty development and you have a
very capable box, do feel free to bump up the machine resources,
though you have to be careful if you're running other software or VMs
on the host.

### Anisble Tasks

Consider if you want to use my emacs24-starter-kit and my-dot-files or
create your own.

### Alternative tasks

I've provided a coupld of alternatives for installing things:

* ruby via rvm (`provision/tasks/rvm-ruby.yml`)
* compile latest emacs24
* compile latest nodejs

## Usage

Bring up the VM for the first time with the command:

    $ vagrant up --provision

Then connect to the box:

    $ vagrant ssh

And you should be good to go. Once in the vagrant user home directory,
change to the `/vagrant` directory, and begin working on your project.

## Contents

The configured software beyond the basic Ubuntu 14.04 release
includes:

* build-essential
* git
* emacs 24
* sqlite3
* postgresql 9.3
* ruby 2.2.0 (with ruby-install and chruby)
* node.js
* nginx
* My own [emacs24-starter-kit](https://github.com/tamouse/emacs24-starter-kit)
* My own set of [dot-files](https://github.com/tamouse/my-dot-files)

You will probably want to use a different set of emacs starter configs
and dot files, which you can fork from mine or build your own.

## Ansible

I've decided I really like Ansible as a provisioning tool. The setup
is so much easier than Chef and Puppet, and certainly easier that
trying to get a single shell script to work correctly repeatedly
without rebuilding the world each time.

## Contributing

If you have questions, comments, suggestions, issues, please use the
[Issues](https://github.com/tamouse/vagrant-ubu14.04-emacs24-ruby-2.2.0-development/issues)
section of the repo on Github.

Also, the standard open source cha-cha-cha:

1. Fork it.
2. Make a branch.
3. Make your changes in the branch and TEST THEM!
4. Make a pull request.
