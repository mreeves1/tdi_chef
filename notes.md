# Notes about Test-Driven Infrastructure with Chef

## General Setup to use a chef server 
Setup your ~/.chef/knife.rb file and set up the chef_server_url, client_key (an rsa prive key or pem file) and the validation_key you get from chef inc (formerly known as opscode). 

## Chef DK (for me) is installed into c:/opt/opcscode/chefdk


## Chapter 3 - An Intro to Chef

### Exercises

#### chef-apply
Run chef on a specific file
eg `chef-apply test.rb` will for instance create a resource like a user.
it is rather limited and for example has no concempt of templates... 
For more complex use cases use chef-solo.

#### chef-solo
runs chef on a stand alone machine without a chef server

##### example solo.rb
```
node_name 'tdi-chap03-solo'
cookbook_path File.expand_path('/vagrant/cookbooks', __FILE__)
ssl_verify_mode :verify_peer

log_level :info
log_location STDOUT
# verbose_logging nil

```

##### running chef solo with overidden run_list
`sudo chef-solo -c solo.rb -o "recipe[irc]"`

##### running chef solo with run_list specified in json file
`sudo chef-solo -c solo.rb -j dna.json`

#### chef-shell
a REPL similar to IRB where you can type in ruby/chef commands

#### chef-client
The client which speaks to a chef server and uses cookbooks, roles, environments, etc. to configure itself

#### ohai
gathers system info about a machine and outputs it in JSON

#### knife
allows you to do deployment, integration, system automation, etc. and is mostly used in a client/server model.

##### Create new cookbook in current directory
`knife cookbook create irc -o .`

##### Create cookbook in default location
Book says this is created in /var/chef/cookbooks but perhaps because I have chef-dk 
it is created in ~/.chef/cookbooks. It also complains about not finding knife.rb
`knife cookbook create silly`

##### Download community cookbooks:
`knife cookbook site download git` # this download a gzipper tarball
`tar xvf git-4.2.2.tar.gz`
`mv git cookbooks`

# a nice one liner to do multiple cookbooks at once
`for dep in build-essential chef_hander dmg git windows yum yum-epel; do knife cookbook site download $dep; tar xzvf $dep*gz -C cookbooks; done`
## Randomness

TIL that `vagrant plugin install foo` is basically just bundler. So foo can be any rubygem. So I installed [omnibus](https://rubygems.org/gems/omnibus) instead of [vagrant-omnibus](https://rubygems.org/gems/vagrant-omnibus by accident)! [The list of plugins](https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins). 
