
# attributes/default.rb

default[:zookeeper][:version]     = '3.4.6'
default[:zookeeper][:checksum]    = '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
default[:zookeeper][:mirror]      = 'http://download.nextag.com/apache/zookeeper/'
default[:zookeeper][:service_style] = 'upstart'





default['mesos']['version']                       = '0.19.1-1.0.ubuntu1204'
default['mesos']['cluster_name']                  = 'MitarbeiterApp'
default['mesos']['isolation_type']                = 'external'
default['mesos']['zookeeper_server_list']         = ['172.10.10.20']
default['mesos']['set_ec2_hostname']              = false

# attributes under default['mesos']['slave'] are written to /etc/mesos-slave/$key = $value
default['mesos']['slave']['checkpoint']           = 'true'
default['mesos']['slave']['strict']               = 'false'
default['mesos']['slave']['recover']              = 'reconnect'
default['mesos']['slave']['containerizer_path']   = '/usr/local/bin/deimos'


default['marathon']['zookeeper_server_list']  = node['mesos']['zookeeper_server_list']
default['marathon']['jar_source']             = 'https://raw.githubusercontent.com/Dimmy15/chef-mitarbeiter/master/resources/marathon-runnable.jar'


default['docker']['version'] = "1.0.1"

