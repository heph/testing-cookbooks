Chef::Log.warn "THIS CODE EXECUTED FROM tester/attributes/default.rb."
default['tester']['static'] = "omghacks"
default['tester']['dynamic']= node['ipaddress']
#default['tester']['dynamic']= node['memory']['total']
Chef::Log.warn "THIS CODE EXECUTED FROM tester/attributes/default.rb. Static: #{node['tester']['static']}, Dynamic: #{node['tester']['dynamic']}"
