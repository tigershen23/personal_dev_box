# -*- mode: ruby -*-
# vi: set ft=ruby :

# this file is read when the vm is booted.  E.g.,"vagrant up" or "vagrant reload"
# see http://docs-v1.vagrantup.com/v1/docs/getting-started/introduction.html

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  # Uncomment this url and comment out the previous one if you intend on using VMWare instead of Virtualbox
  # config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

  # use forward agent so you can use your keys from within vagrant
  config.ssh.forward_agent = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network :forwarded_port, guest: 3000, host: 3000 # rails default
  config.vm.network :forwarded_port, guest: 5001, host: 5000 # flask/python 
  config.vm.network :forwarded_port, guest: 4000, host: 4000 # jekyll

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "1.2.3.4"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # FOR WINDOWS: REMOVE NFS => TRUE. Windows does not support NFS mounts at this time
  config.vm.synced_folder "../code", "/home/vagrant/code", :nfs => true, :create => true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    # vb.customize ["modifyvm", :id, "--memory", "2048"]
    # set ram to 2g, 4 cpus, ioapic on (require for multiple cpus)
    vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "4", "--ioapic", "on"]
    vb.name = "personal_dev"
  end

  # FOR WINDOWS: change this to vmware_workstation if you intend on using VMWare
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "4096"
    v.vmx["numvcpus"] = "4"
  end

  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :shell, :path => "scripts/pre_provision.sh"

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
  end
  
  config.vm.provision :shell, :path => "scripts/post_provision.sh"
end
