
Basic vagrant setup for a Rails development box.

## General

This is a pretty bog-standard development box that I use for
development on multiple projects. I keep all my projects under
`~/Projects` which is where I install the vagrant box. (`vagrant up`
looks up the directory tree until it encounters a `Vagrantfile` file,
and uses that to create the VM.)

## Prerequisites

1. A provider. I use [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://vagrantup.com)
3. [Ansible](http://www.ansible.com/home)

Ansible itself does not support Windows as a control (aka host)
machine and has no plans to. This is a serious limitation for many
people, but not one I'm capable of solving at the moment.

## Installation

A couple of options here:

1. Fork your own version of the starter kit (recommended).
2. Pull down the latest zip file and just use/modify what's there for
   your local project (recommended after you have a setup of your own
   you like).

Really, you should fork your own version of this, and your own
versions of my-dot-files and my emacs24-starter-kit because you want
this all to be your own stuff.

## Configurations and Customizations

I've used this starter kit several times, but for every instance where
I've used it, I've had tweak it.

### Vagrantfile

Three ruby constants are set near the top of the `Vagrantfile`:

* `BOX_NAME` - the name you'd like to give your vagrant box. This is also used as the hostname.
* `BOX_IP` - the IP address to use for the box's private network
* `BOX_URL` - the url of the remote vagrant box to copy in for this installation

By default, these are:

| constant | value |
|:---------|:------|
| `BOX_URL` | 'https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box' |
| `BOX_NAME` | 'jessie' |
| `BOX_IP` | '192.168.100.10' |

If you set shell environment variables to match these constants, those
values will override the set values. Be careful about that though
because if you forget to have them set after you've loaded and
provisioned the box, things will probably break.

### `/etc/hosts`

The `Vagrantfile` utilizes the ruby `resolv` library to look up the IP
address for the box via:

``` ruby
  config.vm.network "private_network", ip: (Resolv.getaddress("#{BOX_NAME}.local") rescue BOX_IP)
```

This looks in the *host* machine's `/etc/hosts` file for an entry that
matches the value of `BOX_NAME` + `".local"`. In the standard
configuration shown above, this would work out to `jessie.local`. In
the `/etc/hosts` file, then, you'd like an entry that maps the IP
address given in `BOX_IP` to `BOX_NAME.local`:

```
192.168.100.10	jessie.local
```

Of course, you need to ensure it's unique. Using the `".local"` TLD
keeps the resolver from looking out on the Internet for matches.

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

And a bunch of other stuff.

You will probably want to use a different set of emacs starter configs
and dot files, which you can fork from mine or build your own. The
emacs24 stuff is all in one task file, so you can easily omit that
from the playbook if you don't want emacs at all.

## Ansible

I've decided I really like Ansible as a provisioning tool. The setup
is so much easier than Chef and Puppet, and certainly easier that
trying to get a single shell script to work correctly repeatedly
without rebuilding the world each time.

## Contributing

If you have questions, comments, suggestions, issues, please use the
[Issues](https://github.com/tamouse/vagrant-with-ansible-starter-kit/issues)
section of the repo on Github.

Also, the standard open source cha-cha-cha:

1. Fork it.
2. Make a branch.
3. Make your changes in the branch and TEST THEM!
4. Make a pull request.
