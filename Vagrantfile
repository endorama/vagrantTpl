# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

# Manifest configuration defaults
MANIFEST_DEFAULT = {
  name: 'default',
  box: {
    name: 'ubuntu/trusty64',
    url: ''
  },
  network:  {
    ip: '10.0.0.2',
    forwarded_port: []
  },
  virtualbox: {
    gui: false,
    ram: 512,
    cpu: 1,
    cpuexecutioncap: '100'
  }
}

# Read machine configuration from a vagrant.json file
manifest = MANIFEST_DEFAULT.merge(JSON.parse(IO.read('vagrant.json'), symbolize_names: true))

# Read chef configuration from a chef.json file
chef_data = JSON.parse(IO.read('chef/node.json'))

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # see http://stackoverflow.com/a/20431791/715002
  config.vm.define manifest[:name] do |machine|

    # Every Vagrant virtual environment requires a box to build off of.
    machine.vm.box = manifest[:box][:name]

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    machine.vm.box_url = manifest[:box][:url]

    # Bridged networking
    machine.vm.network :private_network, ip: manifest[:network][:ip]

    manifest[:network][:forwarded_port].each do |port|
      config.vm.network 'forwarded_port', guest: port[:guest], host: port[:host]
    end

    # Set machine hostname
    machine.vm.hostname = manifest[:name]

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder '.', '/vagrant',
    #                         id: 'vagrant-root',
    #                         owner: 'vagrant',
    #                         group: 'www-data',
    #                         mount_options: ['dmode=775,fmode=664']

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    config.vm.provider :virtualbox do |vb|
      vb.name = manifest[:name]

      # Don't boot with headless mode
      vb.gui = manifest[:virtualbox][:gui]

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ['modifyvm', :id, '--memory', manifest[:virtualbox][:ram]]
      vb.customize ['modifyvm', :id, '--cpus', manifest[:virtualbox][:cpu]]
      vb.customize ['modifyvm', :id, '--cpuexecutioncap', manifest[:virtualbox][:cpuexecutioncap]]
    end

    config.librarian_chef.cheffile_dir = 'chef'

    # Use Chef Solo to provision the virtual machine
    config.vm.provision :chef_solo, run: 'always' do |chef|
      # http://docs.vagrantup.com/v2/provisioning/chef_common.html
      # http://docs.vagrantup.com/v2/provisioning/chef_solo.html

      chef.cookbooks_path = [ '.chef/cookbooks', '.chef/site-cookbooks' ]

      # chef.log_level = :warn
      chef.log_level = :debug

      chef.run_list = chef_data.delete('run_list')
      chef.json = chef_data
    end

    # This should fix https://github.com/mitchellh/vagrant/issues/5199
    config.trigger.before :reload, stdout: true do
      `rm .vagrant/machines/#{manifest[:name]}/virtualbox/synced_folders`
    end
    config.trigger.after :halt, stdout: true do
      `rm .vagrant/machines/#{manifest[:name]}/virtualbox/synced_folders`
    end

  end

end
