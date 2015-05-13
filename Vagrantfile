# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nfq/wheezy"
  
  config.vm.provision "shell" do |s|
	s.path = "scripts/cdh5_repo.sh"
  end
  
  config.vm.provision "pup", type: "puppet" do |puppet|
	puppet.module_path = "manifests/modules"
	puppet.facter = {
      "fqdn" => "hooli.com",
	  "master_ipaddress" => "192.168.33.11"
    }
  end
    
  config.vm.define "master.hooli.com" do |master|
    master.vm.network :private_network, ip: "192.168.33.11"
    master.vm.provider :virtualbox do |vb|
	  vb.memory = 512
    end
	master.vm.provision "pup", type: "puppet" do |puppet|
		puppet.facter = {
		  "hostname" => "master",
		  "ipaddress" => "192.168.33.11",
		}
	end
  end
end