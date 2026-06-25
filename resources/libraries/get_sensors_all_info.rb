module RbProxy
  module Helpers
    def get_sensors_all_info
      sensors_info = {}
      sensor_types = %w(vault-sensor flow-sensor mse-sensor scanner-sensor meraki-sensor ale-sensor device-sensor snmp-sensor redfish-sensor ipmi-sensor vmware-exsi-sensor vmware-exsi-vm-sensor)

      sensor_types.each do |s_type|
        sensors =
          if s_type == 'vmware-exsi-vm-sensor'
            hosts = search(:node, "role:vmware-exsi-sensor AND redborder_parent_id:#{node['redborder']['sensor_id']}")
            host_ids = hosts.map { |h| h['redborder'] && h['redborder']['sensor_id'] }.compact
            if host_ids.empty?
              []
            else
              query_str = host_ids.map { |id| "redborder_parent_id:#{id}" }.join(" OR ")
              search(:node, "role:vmware-exsi-vm-sensor AND (#{query_str})").sort
            end
          else
            search(:node, "role:#{s_type} AND redborder_parent_id:#{node['redborder']['sensor_id']}").sort
          end

        sensors_info[s_type] = []
        sensors.each { |s| sensors_info[s_type] << s }
      end

      sensors_info
    end
  end
end
