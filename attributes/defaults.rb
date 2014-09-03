default[:mesos] = {
  :type    => "mesosphere",
  :mesosphere => {
    :with_zookeeper => true
  },
  :version => "0.19.1",
  :slave   => {
    :isolation=> "cgroups/cpu,cgroups/mem"
  }
}