#
# Cookbook mitarbeiterapp::mongo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# create data Volume for Mongo DB Container
directory "/opt/mongo/db" do
  owner "root"
  group "root"
  mode 00644
  recursive true
  action :create
end

# Remove Mongodb if already present

docker_container 'mongodb' do
  signal 'QUIT'
  action :kill
end


# Create it

docker_image 'tile/we_mongodb:v1'

docker_container 'tile/we_mongodb:v1' do
  container_name 'mongodb'
  detach true
  port ['5000:27017','5001,28017']
  #env 'SETTINGS_FLAVOR=local'
  volume '/opt/mongo/db:/data/db'
  cmd_timeout 6000
  command '--rest --httpinterface'
end
