module RbProxy
  module Helpers
    def get_pipelines
      vortex_pipelines = []
      sensors = get_sensors_info()
      proxy_config = get_monitor_configuration()
      has_device_sensors = !sensors['device-sensor'].nil? && !sensors['device-sensor'].empty?
      has_snmp_sensors = !sensors['snmp-sensor'].nil? && !sensors['snmp-sensor'].empty?
      has_redfish_sensors = !sensors['redfish-sensor'].nil? && !sensors['redfish-sensor'].empty?
      contains_thermal = proxy_config.include?('thermal')
      contains_bulkstats = proxy_config.include?('bulkstats_schema')

      vortex_pipelines.push('redfish-pipeline') if (has_device_sensors || has_redfish_sensors) && contains_thermal
      vortex_pipelines.push('bulkstats-pipeline') if (has_device_sensors || has_snmp_sensors) && contains_bulkstats

      vortex_pipelines
    end
  end
end
