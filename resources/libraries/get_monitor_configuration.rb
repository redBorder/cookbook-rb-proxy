module RbProxy
  module Helpers
    def get_monitor_configuration
      proxy_config = []
      sensor = search(:node, 'redborder_monitors:[* TO *] AND name:*device*').sort
      sensor.each do |node|
        monitors = node.normal['redborder']['monitors']
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
