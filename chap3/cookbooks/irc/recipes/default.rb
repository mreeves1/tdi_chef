#
# Cookbook Name:: irc
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'tdi' do
  action :create
  comment "Test Driven Infra"
  home "/home/tdi"
  shell "/bin/bash"
  supports :manage_home => true
end

package 'irssi' do
  action :install
end

directory '/home/tdi/.irssi' do
  owner 'tdi'
  group 'tdi'
  action :create
end

cookbook_file 'irssi.dotfile' do
  path '/home/tdi/.irssi/config'
  owner 'tdi'
  group 'tdi'
  action :create_if_missing
end 
