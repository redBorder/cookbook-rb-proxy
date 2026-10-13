module RbProxy
  module Helpers
    # Get nodes of a specific type for this proxy
    def get_nodes(sensor_type)
      get_proxy_sensors_with_role(sensor_type)
    end
  end
end
