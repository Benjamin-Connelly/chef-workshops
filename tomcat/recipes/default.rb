#
# Cookbook Name:: tomcat8
# Recipe:: default
#

package %w(java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk.x86_64) do
  action :install
end

group "tomcat" do
  action :create
end
user "tomcat" do
  group "tomcat"
  shell "/bin/false"
  home "/opt/tomcat8"
end

tmp_path = Chef::Config[:file_cache_path]

#Download tomcat archive
remote_file "#{tmp_path}/tomcat8.tar.gz" do
  source node["tomcat8"]["download_url"]
  owner node["tomcat8"]["tomcat_user"]
  mode "0644"
  action :create
end

#create tomcat install dir
directory node["tomcat8"]["install_location"] do
  owner node["tomcat8"]["tomcat_user"]
  mode "0755"
  action :create
end

#Extract the tomcat archive to the install location
bash "Extract tomcat archive" do
  user node["tomcat8"]["tomcat_user"]
  cwd node["tomcat8"]["install_location"]
  code <<-EOH
    tar -zxvf #{tmp_path}/tomcat8.tar.gz --strip 1
  EOH
  action :run
end

#Install server.xml from template
template "#{node["tomcat8"]["install_location"]}/conf/server.xml" do
  source "server.xml.erb"
  owner node["tomcat8"]["tomcat_user"]
  mode "0644"
end

execute "chown -hR tomcat:tomcat tomcat8" do
  cwd "/opt"
end


#Install init script
template "/etc/systemd/system/tomcat.service" do
    source "tomcat.service.erb"
  owner "root"
  mode "0755"
end

execute "systemctl daemon-reload"

#Start and enable tomcat service if requested
service "tomcat" do
  action [:enable, :start]
end
