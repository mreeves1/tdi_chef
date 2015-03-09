# Notes about Test-Driven Infrastructure with Chef

## General Setup to use a chef server 
Setup your ~/.chef/knife.rb file and set up the chef_server_url, client_key (an rsa prive key or pem file) and the validation_key you get from chef inc (formerly known as opscode). 

## Chef DK (for me) is intalled into c:/opt/opcscode/chefdk


## Chapter 3 - An Intro to Chef

### Exercises

#### chef-apply
Run chef on a specific file
eg chef-apply test.rb will for instance create a file from a template file, etc.

#### chef-solo
runs chef on a stand alone machine without a chef server

#### chef-shell
a REPL similar to IRB where you can type in ruby/chef commands

#### chef-client
The client which speaks to a chef server and uses cookbooks, roles, environments, etc. to configure itself

#### ohai
gathers system info about a machine and outputs it in JSON

#### knife
allows you to do deployment, integration, system automation, etc. and is mostly used in a client/server model.
