#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'apt-get update' do
	action :run
end

#package 'mysql-server' do
#	action :install
#end

#package 'mysql-client' do
#	action :install
#end

#execute 'service apache2 stop' do
#	action :run
#end

execute 'update-rc.d -f apache2 remove' do
	action :run
end

execute 'apt-get remove apache2' do
	action :run
end

package 'nginx' do
	action :install
end

cookbook_file "/var/www/html/index.php" do
	source "index.php"
	mode  "0644"
end

cookbook_file "/etc/nginx/sites-available/default" do
	source "default"
	mode  "0644"
end

service 'nginx' do
	action :start
end

package 'php5-fpm' do
	action :install
end

execute "Do some sed" do
	command "sudo sed -i 's/;cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini"
	action :run
end

service 'php5-fpm' do
	action :reload
end

service 'nginx' do
	action :restart
end