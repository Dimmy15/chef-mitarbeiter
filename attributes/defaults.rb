#include_recipe "mesos"
#
#override[:mesos] = {
#  :type    => "mesosphere",
#  :mesosphere => {
#    :with_zookeeper => true
#  },
#  :version => "0.19.1",
#  :slave   => {
#    :isolation=> "external"
#  }
#}


default['mesos']['type'] = 'mesosphere'
default['mesos']['mesosphere']['with_zookeeper'] = 'true'
default['mesos']['version'] = "0.19.1"
default['mesos']['slave']['isolation'] = "external"
default['mesos']['master']['zk'] = 'zk://localhost:2128/mesos'
default['mesos']['master']['quorum'] = 1