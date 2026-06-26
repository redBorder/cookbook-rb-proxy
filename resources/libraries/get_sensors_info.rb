module RbProxy
  module Helpers
    def get_sensors_info
      sensors_info = {}
      sensor_types = %w(vault-sensor flow-sensor mse-sensor scanner-sensor meraki-sensor ale-sensor device-sensor snmp-sensor redfish-sensor ipmi-sensor http_agent-sensor vmware_exsi-sensor vmware_exsi_vm-sensor)

      locations = {}
      if node['redborder'] && node['redborder']['locations']
        locations = node['redborder']['locations']
      end

      sensor_types.each do |s_type|
        sensors =
          if s_type == 'vmware-exsi-vm-sensor'
            hosts = search(:node, "role:vmware-exsi-sensor AND redborder_parent_id:#{node['redborder']['sensor_id']}")
            host_ids = hosts.map { |h| h['redborder'] && h['redborder']['sensor_id'] }.compact
            if host_ids.empty?
              []
            else
              query_str = host_ids.map { |id| "redborder_parent_id:#{id}" }.join(' OR ')
              search(:node, "role:vmware-exsi-vm-sensor AND (#{query_str})").sort
            end
          else
            search(:node, "role:#{s_type} AND redborder_parent_id:#{node['redborder']['sensor_id']}").sort
          end
        info = {}
        found_sensor = false

        sensors_info[s_type] = {}
        sensors.each do |s|
          found_sensor = true
          info['name'] = s.name
          info['ip'] = s['ipaddress']
          info['sensor_uuid'] = s['redborder']['sensor_uuid'] if s['redborder']['sensor_uuid']
          info['organization_uuid'] = s['redborder']['organization_uuid'] if s['redborder']['organization_uuid']
          info['megabytes_limit'] = s['redborder']['megabytes_limit'] if s['redborder']['megabytes_limit']
          info['index_partitions'] = s['redborder']['index_partitions'] if s['redborder']['index_partitions']
          info['index_replicas'] = s['redborder']['index_replicas'] if s['redborder']['index_replicas']
          info['sensors_mapping'] = s['redborder']['sensors_mapping'] if s['redborder']['sensors_mapping']
          info['locations'] = {}

          locations.each do |loc|
            next unless s['redborder'][loc]

            info['locations'][loc] = s['redborder'][loc]
          end

          sensors_info[s_type][s.name] = info if found_sensor
        end
      end

      sensors_info
    end
  end
end
