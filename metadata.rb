name 'mitarbeiterapp'
maintainer 'Timm'
maintainer_email 'timm@hojoki.com'
license 'Apache 2.0'
description 'Installs and Manage components for mitarbeiterapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.0'

recipe 'mitarbeiterapp::mongo', 'Installs/Configures mongo container'
recipe 'mitarbeiterapp::mesos', 'Installs/Configures mongo container'
recipe 'mitarbeiterapp::zookeeper', 'Installs/Configures mongo container'
recipe 'mitarbeiterapp::zookeeper', 'Installs/Configures mongo container'


depends 'docker'
depends 'apt'
depends 'docker'
depends 'zookeeper'
depends 'mesos'
depends 'marathon'

provides 'mitarbeiterapp'
provides 'mitarbeiterapp::mongo'
provides 'mitarbeiterapp::mesos-slave'
provides 'mitarbeiterapp::mesos-master'
provides 'mitarbeiterapp::zookeeper'
#provides 'mitarbeiterapp::zookeeper'


