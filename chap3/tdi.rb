user 'tdi' do
  action :create
  comment "Test Driven Infra"
  home "/home/tdi"
  shell "bin/bash"
  supports :manage_home => true
end

# Chef can run arbitrary ruby
# 10.times { puts "foo\n" }

# This will not work because chef-apply is limited and has no context of templates, etc.
# template '/home/tdi/.tdi' do
#  action :create
#  source 'tdi-bashfile'
# end 
