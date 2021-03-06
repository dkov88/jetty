#
# Cookbook Name:: jetty
# Recipe:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'java' if node['jetty']['install_java']

package ['jetty', 'libjetty-extra'] do
  action :install
end

template '/etc/default/jetty' do
  source 'default_jetty.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[jetty]'
end

template '/etc/jetty/jetty.xml' do
  source 'jetty.xml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[jetty]'
end

service 'jetty' do
  supports restart: true, status: true
  action [:enable, :start]
end
