IMAGE_NAME = "ubuntu/focal64"
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
      
    config.vm.define "master1" do |master|
      master.vm.provider "virtualbox" do |vb|
        vb.memory = "3072"
        vb.cpus = 2
      end
        master.vm.box = IMAGE_NAME
        #v.memory = 2048
        master.vm.network "private_network", ip: "192.168.10.10"
        master.vm.hostname = "master1"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "prv/setup.yml"
            ansible.extra_vars = {
                node_ip: "192.168.10.10",
            }
        end
    end

    (1..N).each do |i|
        config.vm.define "node#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.10.#{i + 10}"
            node.vm.hostname = "node#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "prv/setup.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.10.#{i + 10}",
                }
            end
        end
    end
end
