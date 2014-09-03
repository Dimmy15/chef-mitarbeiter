
source 'https://api.berkshelf.com'

metadata

cookbook 'apt'
cookbook 'docker', '~> 0.35.2'
cookbook 'zookeeper', '~> 2.4.1'
#cookbook 'mesos', '~> 1.0.6'
cookbook "mesos", github: "everpeace/cookbook-mesos"

group :integration do
  cookbook 'minitest-handler'
end
