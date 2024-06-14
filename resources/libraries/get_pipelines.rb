module RbProxy
  module Helpers
    def get_pipelines
      logstash_pipelines = []
      sensors = get_sensors_info()

      if proxy_services['logstash']
        logstash_pipelines.push('redfish-pipeline') unless sensors['device-sensor'].empty?
        logstash_pipelines.push('bulkstats-pipeline') unless sensors['device-sensor'].empty?
      end
      logstash_pipelines
    end
  end
end
