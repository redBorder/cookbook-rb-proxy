# Cookbook:: proxy
# Recipe:: default
# Copyright:: 2024, redborder
# License:: Affero General Public License, Version 3

include_recipe 'rb-proxy::prepare_system'
include_recipe 'rb-proxy::configure'
include_recipe 'rb-proxy::configure_journald'
