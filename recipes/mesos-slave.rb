
include_recipe 'docker'

package "python-pip" do
	action :install
end

bash "install_deimos" do
	code <<-EOH
		pip install deimos
		EOH
	action :run
end

include_recipe 'mesos::slave'
