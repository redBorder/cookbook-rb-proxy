module RbProxy
  module Helpers
    # Get nodes of a specific type for this proxy
    def get_nodes(sensor_type)
      proxy_id = node['redborder']['sensor_id']
      search(:node, "role:#{sensor_type} AND redborder_parent_id:#{proxy_id}").sort
    end
  end
end
