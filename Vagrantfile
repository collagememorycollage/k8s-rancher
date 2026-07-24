hosts = { 
  "workerNode" => "192.168.31.100", 
  "masterNode" => "192.168.31.101" 
}

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  
  hosts.each do |name, ip|
    config.vm.define name do |machine|
      machine.vm.network :private_network, ip: ip
      
      machine.vm.provider "virtualbox" do |v|
        v.name = name
        v.gui = false # Измените на true, если нужен графический интерфейс
        v.memory = 4096
        v.cpus = 2
      end
      
      #machine.vm.provision "shell", path: "provision.sh"
      machine.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true
    end
  end
end

