#
# Cookbook Name:: proxy
# Recipe:: prepare_system
#
# Copyright 2022, redborder
#
# AFFERO GENERAL PUBLIC LICENSE V3
#
extend Rb_proxy::Helpers

puts "Hello im in prepare_system"

#clean metadata to get packages upgrades
execute "Clean yum metadata" do
  command "yum clean metadata"
end