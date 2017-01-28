Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder "./", "/home/ubuntu/dotfiles", create: true

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
   end

  config.vm.provider "virtualbox" do |v|
    v.name = "dotfiles"
  end

end
