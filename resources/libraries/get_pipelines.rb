module RbProxy
  module Helpers
    def get_pipelines
      logstash_pipelines = []
      sensors = get_sensors_info()
      proxy_config = get_monitor_configuration()
      has_device_sensors = !sensors['device-sensor'].nil? && !sensors['device-sensor'].empty?
      contains_thermal = proxy_config.include?('thermal')
      contains_bulkstats = proxy_config.include?('bulkstats_schema')

      logstash_pipelines.push('redfish-pipeline') if has_device_sensors && contains_thermal
      logstash_pipelines.push('bulkstats-pipeline') if has_device_sensors && contains_bulkstats

      logstash_pipelines
    end
  end
end
