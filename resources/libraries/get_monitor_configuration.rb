module RbProxy
  module Helpers
    def get_monitor_configuration
      proxy_config = []
      monitor_sensors = get_monitor_sensors_by_role.values.flatten.uniq(&:name)
      monitor_sensors.each do |sensor|
        next unless sensor['redborder'] && sensor['redborder']['monitors']

        monitors = sensor.normal['redborder']['monitors'] || []
        monitors.each do |monitor|
          if monitor['name'] == 'bulkstats_schema' || monitor['name'] == 'thermal'
            proxy_config << monitor['name']
          end
        end
      end
      proxy_config
    end
  end
end
