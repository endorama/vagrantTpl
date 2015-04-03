# -*- mode: ruby -*-
# vi: set ft=ruby :

# For options documentation see https://docs.chef.io/config_rb_solo.html
# Both Vagrant and manual install will use this file :) Nice and clean

CURRENT_DIR = Pathname(File.expand_path(File.dirname(__FILE__)))
CHEF_DIR = CURRENT_DIR.join('chef')

######################### DO NOT TOUCH BEHIND THIS LINE ########################
################################################################################

# Use to run the chef-client in chef-solo mode. This setting determines if the 
#  chef-client should attempt to communicate with the Chef server. 
#  Default value: false.
solo true

# The path to a file that contains JSON data.
json_attribs CHEF_DIR.join('node.json').to_s

# The sub-directory for cookbooks on the chef-client. This value can be a string
#  or an array of file system locations, processed in the specified order. The
#  last cookbook is considered to override local modifications.
cookbook_path [ CHEF_DIR.join('cookbooks'), CHEF_DIR.join('site-cookbooks') ]

# checksum_path    CHEF_DIR.join('checksums')
# data_bag_path    CHEF_DIR.join('data_bags')
# environment_path CHEF_DIR.join('environments')
# file_backup_path CHEF_DIR.join('backup')
# file_cache_path  CHEF_DIR.join('cache')
# role_path        CHEF_DIR.join('roles')
# sandbox_path     CHEF_DIR.join('sandbox')

# The level of logging that will be stored in a log file. 
#  Possible levels: :auto (default), debug, info, warn, error, or fatal.
# log_level :debug

# The location in which log file output files will be saved. If this location is
#  set to something other than STDOUT, standard output logging will still be 
#  performed (otherwise there would be no output other than to a file). 
#  Default value: STDOUT.
time = Time.now
log_location CHEF_DIR.join('logs', 
  "#{time.year}-#{time.month}-#{time.day}_#{time.hour}-#{time.min}-#{time.sec}.log")
