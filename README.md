# VagrantTpl

A Vagrant Template for machine configuration using Chef, both in development 
environment using Vagrant and on deploy using Chef Solo.

## Installation

To install in your repository copy files inside repo folder.

You then will have to edit:

- Cheffile: insert here cookbooks you want to use
- .chef/node.json: configure run list and cookbooks options
- .vagrant/manifest.json: configure the Vagrant machine to your needs

Install releavant gems with `gem install`.  
Install releavant cookbooks with `librarian-chef init`.  


## Running

### Vagrant

Vagrant will perform provisioning every time is started up or reloaded using the
Chef Solo provider

### Custom server

Use Chef Solo standalone with the script provided in `.chef/solo.rb`. Node data
are stored in `.chef/node.json`.