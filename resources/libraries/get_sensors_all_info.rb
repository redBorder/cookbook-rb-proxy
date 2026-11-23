module RbProxy
  module Helpers
    def get_sensors_all_info
      sensors_info = {}
      sensor_types = %w(vault-sensor flow-sensor mse-sensor scanner-sensor meraki-sensor ale-sensor device-sensor snmp-sensor redfish-sensor ipmi-sensor http_agent-sensor vmware-exsi-sensor vmware-exsi-vm-sensor trap-sensor)

      sensor_types.each do |s_type|
        sensors_info[s_type] = get_proxy_sensors_with_role(s_type)
      end

      sensors_info
    end
  end
end
