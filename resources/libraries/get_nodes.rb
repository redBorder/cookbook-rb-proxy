module RbProxy
  module Helpers
    # Format of nodes differs from roles, in this case, we extract the info in node format
    def get_nodes(sensor_types = ['flow-sensor'])
      sensors_info = {}
      proxy_id = node['redborder']['sensor_id']
      sensor_types.each do |s_type|
        sensors = search(:node, "role:#{s_type} AND redborder_parent_id:#{proxy_id}").sort
        sensors_info[s_type] = []
        sensors.each { |s| sensors_info[s_type] << s }
      end
      sensors_info
    end
  end
end
