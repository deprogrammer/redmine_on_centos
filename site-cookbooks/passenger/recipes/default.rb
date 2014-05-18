%w{openssl-devel readline-devel zlib-devel curl-devel
   libyaml-devel httpd httpd-devel apr-devel apr-util-devel}.each do |p|
  package p do
    action :install
  end
end

gem_package "passenger" do
  action :install
end

execute "passenger.install" do
  command "passenger-install-apache2-module --auto"
  action :run
end

template "#{node['apache']['dir']}/conf.d/passenger.conf" do
#    cookbook "passenger"
    source "passenger.conf.erb"
    owner "root"
    group "root"
    mode 0644
end

