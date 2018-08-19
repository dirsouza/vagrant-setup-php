Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.box_version = "20180814.0.0"
    config.vm.network :private_network, ip: "192.168.33.10"
    config.ssh.guest_port = 2222
    config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
    config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true
    config.vm.synced_folder "www/", "/var/www", owner: "www-data", group: "www-data", mount_options: ['dmode=777','fmode=666']
    config.vm.synced_folder "~", "/vagrant", owner: "vagrant", group: "vagrant"
    config.vm.provider "virtualbox" do |machine|
    	machine.memory = 1024
    	machine.name = "ServidorWeb"
    end
    # INSTALAÇÃO DOS PACOTES DO SERVIDOR
    config.vm.provision :shell, path: "config/setup.sh"
    # CONFIGURAÇÕES DE VIRTUALHOSTS E BANCO DE DADOS
    config.vm.provision :shell, path: "config.sh"
end
