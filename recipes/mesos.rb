

# fed60e529b03d37703772b92de888ac72036e08dccd78dd3efc415dc32b033e5 *mesos_0.19.1-1.0.ubuntu1404_amd64.deb
# 59196eb8b80ecb409ca9d4c70b00c7bcbdfda02ba00096de05c475a285a92413 *mesos-0.19.1-1.0.redhat64.x86_64.rpm



#mesos::mesosphere


#[mesos][master] = {
#  :port    => 5050,
#  :log_dir => "/var/log/mesos",
#  :zk      => "zk://node['ipaddress']:2181/mesos",
#  :cluster => "MyCluster",
#  :quorum  => 1
#}


#[:mesos][:slave] = {
#  :master    => "zk://localhost:2181/mesos",
#  :log_dir   => "/var/log/mesos",
#  :work_dir  => "/var/run/work"
#}


apt_repository "mesosphere" do
  uri "http://repos.mesosphere.io"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E56151BF"
end

package "mesos" do
  version "0.19.1"
  action :install
end


config_hash = {
  clientPort: 2181, 
  dataDir: '/var/lib/zookeeper', 
  tickTime: 2000,
  autopurge: {
    snapRetainCount: 1,
    purgeInterval: 1
  }
}

zookeeper_config '/opt/zookeeper/zookeeper-3.4.6/conf/zoo.cfg' do
  config config_hash
  user   'zookeeper'
  action :render
end