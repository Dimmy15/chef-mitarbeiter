

include_recipe 'zookeeper'

zookeeper '3.4.6' do
  user     'zookeeper'
  mirror   'http://download.nextag.com/apache/zookeeper/'
  checksum '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
  action   :install
end

config_hash = {
  clientPort: 2181, 
  dataDir: '/tmp/zk', 
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

#include_recipe zookeeper::service