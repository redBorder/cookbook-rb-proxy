module RbProxy
  module Helpers
    # Get nodes of a specific type for this proxy
    def get_nodes(sensor_type)
      proxy_id = node['redborder']['sensor_id']
      if sensor_type == 'vmware-exsi-vm-sensor'
        hosts = search(:node, "role:vmware-exsi-sensor AND redborder_parent_id:#{proxy_id}")
        host_names = hosts.map(&:name)
        search(:node, 'role:vmware-exsi-vm-sensor').select do |vm|
          parent_id = vm.dig('redborder', 'parent_id')
          host_names.include?("rbvmware-exsi-#{parent_id}")
        end.sort
      else
        search(:node, "role:#{sensor_type} AND redborder_parent_id:#{proxy_id}").sort
      end
    end
  end
end
