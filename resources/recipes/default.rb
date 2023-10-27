#
# Cookbook Name:: proxy
# Recipe:: default
#
# Copyright 2022, redborder
#
# AFFERO GENERAL PUBLIC LICENSE V3
#

include_recipe 'rb-proxy::prepare_system'
include_recipe 'rb-proxy::configure'
include_recipe 'rb-ips::configure_cron_tasks'
