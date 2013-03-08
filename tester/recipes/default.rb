#
# Cookbook Name:: tester
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

message = "THIS CODE EXECUTED FROM tester/recipes/default.rb. Static: #{node['tester']['static']}, Dynamic: #{node['tester']['dynamic']}"

Chef::Log.warn message

file '/tmp/dumper' do
  content message
end
