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

## Chapter 4 - Chef Tools

### Exercises

#### Create opscode user and new organization

You need a user key and a validation key which you get from the opscode site.
Your validation key is used to bootstrap new nodes. 

These files usually go in ~/.chef/ 

#### Example knife.rb: 

```
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "your_laptop_name"
client_key               "#{current_dir}/your_name.pem"
validation_client_name   "your-chef-server-organization-name-validator"
validation_key           "#{current_dir}/your-chef-server-organization-name-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/your-chef-server-organization-name"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"] 

```

I prefer to have the cookbooks elsewhere but you can add to the `cookbook_path` array easily. 

#### Validate chef-server and client setup worked with:
`knife client list`

#### Install more cookbooks:
`for dep in chruby ark ruby_build; do knife cookbook site download $dep; tar xzvf $dep*gz -C cookbooks; done`

#### Upload your cookbooks:
`knife cookbook upload -o cookbooks --all --include-dependencies` # this may throw errors and you will need to run `knife site download`, etc...

#### Setup your client with the chef-server:
`knife configure client .`
This will generate client.rb and validation.pem. You should copy those to /etc/chef. 
Then you can run `sudo chef-client -j dna.json` to run chef-client locally which will register your computer as a node. We will us a similar technique to do the same with our vagrant boxes. See Vagrantfile for details. 

Run vagrant provision after tweaking things, uploading cookbooks, etc.

