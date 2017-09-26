#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install MongoDB RPM repo
template "/etc/yum.repos.d/mongodb-org-3.4.repo" do
    source "mongodb-org-3.4.repo.erb"
  owner "root"
  mode "0644"
end

# Clean yum cache
execute "yum clean expire-cache"

# Install MongoDB
yum_package "mongodb-org" do
  action :install
end

#Start and enable MongoDB service if requested
service "mongod" do
  action [:enable, :start]
end
