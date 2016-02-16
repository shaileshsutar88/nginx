#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, Opex Software
#
# All rights reserved - Do Not Redistribute
#
# Author : Shailesh Sutar

execute 'apt-get update' do
	action :run
end

execute 'update-rc.d -f apache2 remove' do
	action :run
end

package 'apache2' do
	action :remove
end

package 'nginx' do
	action :install
end

cookbook_file "/var/www/html/index.php" do
	source "index.php"
	mode  "0644"
end

template "/etc/nginx/sites-available/default" do
	source "default.erb"
	owner "root"
	group "root"
	mode  "0644"
	notifies :restart, "service[nginx]"
end

package 'php5-fpm' do
	action :install
end

execute "Do sed" do
	command "sudo sed -i 's/;cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini"
	action :run
end

service 'php5-fpm' do
	action :reload
end

service 'nginx' do
	action :restart
end
