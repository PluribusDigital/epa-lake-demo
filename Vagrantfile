# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = true

  config.vm.network "forwarded_port", guest: 3334, host: 8080

  config.vm.synced_folder ".", "/home/vagrant"

  config.vm.provider "virtualbox" do |v|
    v.name = "epa-lake"
  end

  config.vm.provision "docker"

  config.vm.provision "shell", inline: "docker build -t app .", run: "always"

  #config.vm.provision "shell", inline: "docker run -d -p 3334:80 -v /home/vagrant:/home/app/webapp app", run: "always"

end
