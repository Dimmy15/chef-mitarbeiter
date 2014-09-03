include_recipe "mesos"

override[:mesos] = {
  :type    => "mesosphere",
  :mesosphere => {
    :with_zookeeper => true
  },
  :version => "0.19.1",
  :slave   => {
    :isolation=> "external"
  }
}