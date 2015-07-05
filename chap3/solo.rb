node_name 'tdi-chap03-solo'
cookbook_path ENV['HOME']
cookbook_path [ File.expand_path('/vagrant/cookbooks', __FILE__), ENV['HOME'] + "/.chef/cookbooks" ]

log_level :info
log_location STDOUT
# verbose_logging nil

# This doesn't actually work... use -o or -j flags to provide run_list
# run_list 'recipe[irc]'
