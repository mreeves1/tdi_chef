user 'tdi' do
  action :create
  comment "Test Driven Infra"
  home "/home/tdi"
  shell "bin/bash"
  supports :manage_home => true
end

template '/home/tdi/.tdi' do
  action :create
  source 'tdi-bashfile'
end 
