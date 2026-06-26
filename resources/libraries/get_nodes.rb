module RbProxy
  module Helpers
    # Get nodes of a specific type for this proxy
    def get_nodes(sensor_type)
      proxy_id = node['redborder']['sensor_id']
      if sensor_type == 'vmware-exsi-vm-sensor'
        hosts = search(:node, "role:vmware-exsi-sensor AND redborder_parent_id:#{proxy_id}")
        host_ids = hosts.map { |h| h['redborder'] && h['redborder']['sensor_id'] }.compact
        if host_ids.empty?
          []
        else
          query_str = host_ids.map { |id| "redborder_parent_id:#{id}" }.join(' OR ')
          search(:node, "role:vmware-exsi-vm-sensor AND (#{query_str})").sort
        end
      else
        search(:node, "role:#{sensor_type} AND redborder_parent_id:#{proxy_id}").sort
      end
    end
  end
end
