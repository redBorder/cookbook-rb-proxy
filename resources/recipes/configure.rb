#
# Cookbook Name:: proxy
# Recipe:: configure
#
# Copyright 2024, redborder
#
# AFFERO GENERAL PUBLIC LICENSE V3
#
# Services configuration

# proxy services
proxy_services = proxy_services()

rb_selinux_config "Configure Selinux" do
  if shell_out("getenforce").stdout.chomp == "Disabled"
    action :remove
  else
    action :add
  end
end

zookeeper_config "Configure Zookeeper" do
    port node["zookeeper"]["port"]
    memory node["redborder"]["memory_services"]["zookeeper"]["memory"]
    hosts [node.name]
    action (proxy_services["zookeeper"] ? [:add] : [:remove])
  end

kafka_config "Configure Kafka" do
    memory node["redborder"]["memory_services"]["kafka"]["memory"]
    #maxsize node["redborder"]["manager"]["hd_services_current"]["kafka"]
    managers_list [node.name]
    zk_hosts node["redborder"]["zookeeper"]["zk_hosts"]
    host_index node["redborder"]["kafka"]["host_index"]
    action (proxy_services["kafka"] ? [:add] : [:remove])
end

geoip_config "Configure GeoIP" do
    action (proxy_services["geoip"] ? :add : :remove)
end

snmp_config "Configure snmp" do
    hostname node["hostname"]
    cdomain node["redborder"]["cdomain"]
    action (proxy_services["snmp"] ? :add : :remove)
end
  
rbmonitor_config "Configure redborder-monitor" do
    name node["hostname"]
    action (proxy_services["redborder-monitor"] ? :add : :remove)
end

rbscanner_config "Configure redborder-scanner" do
    scanner_nodes node["redborder"]["sensors_info_all"]["scanner-sensor"]
    action (proxy_services["redborder-scanner"] ? [:add] : [:remove])
end
  
f2k_config "Configure f2k" do
    sensors node["redborder"]["sensors_info"]["flow-sensor"]
    action (proxy_services["f2k"] ? [:add] : [:remove])
end

pmacct_config "Configure pmacct" do
    sensors node["redborder"]["sensors_info"]["flow-sensor"]
    action (proxy_services["pmacct"] ? [:add] : [:remove])
end

logstash_config "Configure logstash" do
    cdomain node["redborder"]["cdomain"]
    flow_nodes node["redborder"]["sensors_info_all"]["flow-sensor"]
    namespaces node["redborder"]["namespaces"]
    vault_nodes node["redborder"]["sensors_info_all"]["vault-sensor"]
    device_nodes node["redborder"]["sensors_info_all"]["device-sensor"]
    action (proxy_services["logstash"] ? [:add] : [:remove])
end

rsyslog_config "Configure rsyslog" do
    vault_nodes node["redborder"]["sensors_info_all"]["vault-sensor"]
    action (proxy_services["rsyslog"] ? [:add] : [:remove])
end
  
rbnmsp_config "Configure redborder-nmsp" do
    memory node["redborder"]["memory_services"]["redborder-nmsp"]["memory"]
    flow_nodes node["redborder"]["sensors_info_all"]["flow-sensor"]
    hosts node["redborder"]["zookeeper"]["zk_hosts"]
    mode "proxy"
    action (proxy_services["redborder-nmsp"] ? [:add, :configure_keys] : [:remove])
end
  
n2klocd_config "Configure n2klocd" do
    mse_nodes node["redborder"]["sensors_info_all"]["mse-sensor"]
    meraki_nodes node["redborder"]["sensors_info_all"]["meraki-sensor"]
    n2klocd_managers [node.name]
    memory node["redborder"]["memory_services"]["n2klocd"]["memory"]
    action (proxy_services["n2klocd"] ? [:add] : [:remove])
end

# TODO: replace node["redborder"]["services"] in action with "proxy_services".. 
rbale_config "Configure redborder-ale" do
    ale_nodes node["redborder"]["sensors_info_all"]["ale-sensor"]
    action (node["redborder"]["services"]["redborder-ale"] ? [:add] : [:remove])
end

rbcgroup_config "Configure cgroups" do
  action :add 
end
  

#--------------------------MOTD--------------------------#

manager =`grep "cloud_address" /etc/redborder/rb_init_conf.yml | cut -d' ' -f2`

template "/etc/motd" do
    source "motd.erb"
    owner "root"
    group "root"
    mode 0644
    retries 2
    variables(:manager_info => node["redborder"]["cdomain"], :manager => manager)
end

## TODO: replace node["redborder"]["services"] in action with "proxy_services".. 
#freeradius_config "Configure radiusd" do
#    flow_nodes node["redborder"]["sensors_info_all"]["flow-sensor"]
#    mode "proxy"
#    action (node["redborder"]["services"]["radiusd"] ? [:config_common] : [:remove])
#end

## TODO: replace node["redborder"]["services"] in action with "proxy_services".. 
#k2http_config "Configure k2http" do
#    action (proxy_services["k2http"] ? [:add] : [:remove])
#end



