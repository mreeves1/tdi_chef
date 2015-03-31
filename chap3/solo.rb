node_name 'tdi-chap03-solo'
cookbook_path File.expand_path('/vagrant/cookbooks', __FILE__)
ssl_verify_mode :verify_peer

log_level :info
log_location STDOUT
# verbose_logging nil

# This doesn't actually work...
# run_list 'recipe[irc]'
