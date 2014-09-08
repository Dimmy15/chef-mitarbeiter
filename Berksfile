
source 'https://api.berkshelf.com'

metadata

cookbook 'apt'
cookbook 'pleaserun', git: 'https://github.com/paulczar/chef-pleaserun'
cookbook 'docker', '~> 0.35.2'
cookbook 'zookeeper', git: 'https://github.com/SimpleFinance/chef-zookeeper'
cookbook 'mesos', '~> 1.0.6'
cookbook 'marathon', '~> 1.0.1'


group :integration do
  cookbook 'minitest-handler'
end
