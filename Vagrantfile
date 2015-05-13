# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nfq/wheezy"
  
  config.vm.provision "shell" do |s|
	s.path = "scripts/cdh5_repo.sh"
  end
  
  config.vm.provision "puppet" do |puppet|
	puppet.facter = {
      "vagrant" => "1"
    }
  end
    
  config.vm.define "master" do |master|
    master.vm.network :private_network, ip: "192.168.33.11"
    master.vm.provider :virtualbox do |vb|
	  vb.memory = 512
    end
	#m1.vm.provision "shell", 
	#	inline: "mesos-master --ip=192.168.33.11 --work_dir=/var/lib/mesos &",
	#	run: "always", privileged: "true"
  end
end