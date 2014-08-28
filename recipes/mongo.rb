#
# Cookbook mitarbeiterapp::mongo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

docker_image 'tile/we_mongodb:v1'

docker_container 'mongodb' do
  detach true
  port '5000:27017'
  port '5001:28017'
  #env 'SETTINGS_FLAVOR=local'
  volume '/mnt/docker:/data'
  command '--rest --httpinterface'
end
