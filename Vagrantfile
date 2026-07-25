hosts = { 
  "workerNode" => { 
    :box => "bento/ubuntu-20.04",
    :hostname => "wc1",
    :ip => "192.168.41.100",
    :ram => 4096,
    :cpu => "2"
  },

  "masterNode" => { 
    :box => "bento/ubuntu-20.04",
    :hostname => "mn1",
    :ip => "192.168.41.101",
    :ram => "4096",
    :cpu => "2"
  },
  
  "DNS" => {
    :box => "bento/ubuntu-20.04", 
    :hostname => "dns",
    :ip => "192.168.41.102",
    :ram => "2048",
    :cpu => "1"
  },

  "Ansible" => {
    :box => "bento/ubuntu-20.04",
    :hostname => "ansible",
    :ip => "192.168.41.103",
    :ram => "2048",
    :cpu => "1"
   }
}

Vagrant.configure("2") do |config|
  
  hosts.each do |name, settings|
    config.vm.define name do |node|
      node.vm.box = settings[:box]
      node.vm.hostname = settings[:hostname]
      node.vm.network "private_network", ip: settings[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.memory = settings[:ram]
        vb.cpus = settings[:cpu]
      end
    end
  end
end




