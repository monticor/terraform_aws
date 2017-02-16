#!/usr/bin/env bash

sudo yum -y install wget
cd /tmp
wget https://packages.chef.io/files/stable/chef-server/12.12.0/el/7/chef-server-core-12.12.0-1.el7.x86_64.rpm
sudo rpm -Uvh /tmp/chef-server-core-12.12.0-1.el7.x86_64.rpm
sudo chef-server-ctl reconfigure

sudo chef-server-ctl install chef-manage --accept-license
sudo chef-server-ctl reconfigure --accept-license
sudo chef-manage-ctl reconfigure --accept-license
