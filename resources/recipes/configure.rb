# Cookbook:: proxy
# Recipe:: configure
# Copyright:: 2024, redborder
# License:: Affero General Public License, Version 3

# Services configuration

proxy_services = proxy_services()

begin
  split_traffic_logstash_db = data_bag_item('rBglobal', 'splittraffic')
  split_traffic_logstash = split_traffic_logstash_db['logstash']
rescue
  split_traffic_logstash = false
end

rb_common_config 'Configure common' do
  sensor_role 'proxy-sensor'
  action :configure
end

rb_selinux_config 'Configure Selinux' do
  if shell_out('getenforce').stdout.chomp == 'Disabled'
    action :remove
  else
    action :add
  end
end

rb_firewall_config 'Configure Firewall' do
  if proxy_services['firewall']
    action :add
  else
    action :remove
  end
end

zookeeper_config 'Configure Zookeeper' do
  port node['zookeeper']['port']
  memory node['redborder']['memory_services']['zookeeper']['memory']
  hosts [node.name]
  if proxy_services['zookeeper']
    action [:add]
  else
    action [:remove]
  end
end

kafka_config 'Configure Kafka' do
  memory node['redborder']['memory_services']['kafka']['memory']
  # maxsize node['redborder']['manager']['hd_services_current']['kafka']
  managers_list [node.name]
  zk_hosts node['redborder']['zookeeper']['zk_hosts']
  host_index node['redborder']['kafka']['host_index']
  if proxy_services['kafka']
    action [:add]
  else
    action [:remove]
  end
end

geoip_config 'Configure GeoIP' do
  user_id node['redborder']['geoip_user']
  license_key node['redborder']['geoip_key']
  action :add
end

snmp_config 'Configure snmp' do
  hostname node['hostname']
  cdomain node['redborder']['cdomain']
  if proxy_services['snmp']
    action :add
  else
    action :remove
  end
end

rbmonitor_config 'Configure redborder-monitor' do
  name node['hostname']
  device_nodes node.run_state['sensors_info_all']['device-sensor']
  flow_nodes node.run_state['sensors_info_all']['flow-sensor']
  if proxy_services['redborder-monitor']
    action :add
  else
    action :remove
  end
end

rbscanner_config 'Configure redborder-scanner' do
  scanner_nodes node.run_state['sensors_info_all']['scanner-sensor']
  cdomain node['redborder']['cdomain']
  if proxy_services['redborder-scanner']
    action [:add]
  else
    action [:remove]
  end
end

f2k_config 'Configure f2k' do
  sensors node.run_state['sensors_info']['flow-sensor']
  if proxy_services['f2k']
    action [:add]
  else
    action [:remove]
  end
end

pmacct_config 'Configure pmacct' do
  sensors node.run_state['sensors_info']['flow-sensor']
  if proxy_services['pmacct']
    sfacctd_ip node['ipaddress']
    action [:add]
  else
    action [:remove]
  end
end

logstash_config 'Configure logstash' do
  cdomain node['redborder']['cdomain']
  flow_nodes node.run_state['sensors_info_all']['flow-sensor']
  namespaces node.run_state['namespaces']
  vault_nodes node.run_state['sensors_info_all']['vault-sensor']
  device_nodes node.run_state['sensors_info_all']['device-sensor']
  logstash_pipelines node.default['pipelines']
  if !logstash_pipelines.nil? && !logstash_pipelines.empty?
    action [:add]
  else
    action [:remove]
  end
end

rsyslog_config 'Configure rsyslog' do
  vault_nodes node.run_state['sensors_info_all']['vault-sensor']
  if proxy_services['rsyslog']
    action [:add]
  else
    action [:remove]
  end
end

rbnmsp_config 'Configure redborder-nmsp' do
  memory node['redborder']['memory_services']['redborder-nmsp']['memory']
  flow_nodes node.run_state['sensors_info_all']['flow-sensor']
  hosts node['redborder']['zookeeper']['zk_hosts']
  mode 'proxy'
  if proxy_services['redborder-nmsp']
    action [:add, :configure_keys]
  else
    action [:remove]
  end
end

n2klocd_config 'Configure n2klocd' do
  mse_nodes node.run_state['sensors_info_all']['mse-sensor']
  meraki_nodes node.run_state['sensors_info_all']['meraki-sensor']
  n2klocd_managers [node.name]
  memory node['redborder']['memory_services']['n2klocd']['memory']
  if proxy_services['n2klocd']
    action [:add]
  else
    action [:remove]
  end
end

rb_exporter_config 'Configure rb-exporter' do
  if proxy_services['redborder-exporter']
    split_traffic_logstash split_traffic_logstash
    action [:add]
  else
    action [:remove]
  end
end

# TODO: replace node['redborder']['services'] in action with 'proxy_services'..
rbale_config 'Configure redborder-ale' do
  ale_sensors = node.run_state['sensors_info_all']['ale-sensor']
  if !ale_sensors.empty?
    ale_nodes ale_sensors
    action [:add]
  else
    action [:remove]
  end
end

k2http_config 'Configure k2http' do
  if proxy_services['k2http']
    action [:add]
  else
    action [:remove]
  end
end

rbcgroup_config 'Configure cgroups' do
  action :add
end

rb_clamav_config 'Configure ClamAV' do
  action :add
end

rb_chrony_config 'Configure Chrony' do
  if proxy_services['chrony']
    action :add
  else
    action :remove
  end
end

# MOTD
manager = `grep 'cloud_address' /etc/redborder/rb_init_conf.yml | cut -d' ' -f2`

template '/etc/motd' do
  source 'motd.erb'
  owner 'root'
  group 'root'
  mode '0644'
  retries 2
  variables(manager_info: node['redborder']['cdomain'], manager: manager)
end

# TODO: replace node['redborder']['services'] in action with 'proxy_services'..
# freeradius_config 'Configure radiusd' do
#   flow_nodes node.run_state['sensors_info_all']['flow-sensor']
#   mode 'proxy'
#  action (node['redborder']['services']['radiusd'] ? [:config_common] : [:remove])
# end

template '/etc/sudoers.d/redBorder' do
  source 'redBorder.erb'
  cookbook 'rb-proxy'
  owner 'root'
  group 'root'
  mode '0440'
  retries 2
end
