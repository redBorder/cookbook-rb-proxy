module RbProxy
  module Helpers
    def get_sensors_all_info
      sensors_info = {}
      sensor_types = %w(vault-sensor flow-sensor mse-sensor scanner-sensor meraki-sensor ale-sensor device-sensor snmp-sensor redfish-sensor ipmi-sensor http_agent-sensor vmware-exsi-sensor vmware-exsi-vm-sensor trap-sensor)

      sensor_types.each do |s_type|
        sensors =
          if s_type == 'vmware-exsi-vm-sensor'
            hosts = search(:node, "role:vmware-exsi-sensor AND redborder_parent_id:#{node['redborder']['sensor_id']}")
            host_names = hosts.map(&:name)
            search(:node, 'role:vmware-exsi-vm-sensor').select do |vm|
              parent_id = vm.dig('redborder', 'parent_id')
              host_names.include?("rbvmware-exsi-#{parent_id}")
            end.sort
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
