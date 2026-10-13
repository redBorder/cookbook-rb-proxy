module RbProxy
  module Helpers
    # Groups the given nodes by the roles set directly in their run_list (same match as role:<name> in a search)
    def group_sensors_by_role(sensors)
      sensors_by_role = Hash.new { |hash, role| hash[role] = [] }
      sensors.each do |s|
        s.run_list.role_names.each { |role| sensors_by_role[role] << s }
      end
      sensors_by_role
    end

    # Gets all the sensors of this proxy with a single search and groups them by role.
    # The result is cached in run_state, so the chef server is queried only once per run
    def get_proxy_sensors_by_role
      node.run_state['proxy_sensors_by_role'] ||=
        group_sensors_by_role(search(:node, "redborder_parent_id:#{node['redborder']['sensor_id']}").sort)
    end

    # Gets all the monitor sensors of the cluster (not only the ones of this proxy) grouped by role.
    # The result is cached in run_state, so the chef server is queried only once per run
    def get_monitor_sensors_by_role
      monitor_roles = %w(device-sensor snmp-sensor redfish-sensor ipmi-sensor http_agent-sensor vmware-exsi-sensor vmware-exsi-vm-sensor)
      node.run_state['monitor_sensors_by_role'] ||=
        group_sensors_by_role(search(:node, monitor_roles.map { |role| "role:#{role}" }.join(' OR ')).sort)
    end

    # Sensors of the given role that belong to this proxy, sorted by name
    def get_proxy_sensors_with_role(role)
      if role == 'vmware-exsi-vm-sensor'
        # the vms are childs of the vmware-exsi hosts of this proxy
        host_names = get_proxy_sensors_by_role['vmware-exsi-sensor'].map(&:name)
        get_monitor_sensors_by_role['vmware-exsi-vm-sensor'].select do |vm|
          parent_id = vm.dig('redborder', 'parent_id')
          host_names.include?("rbvmware-exsi-#{parent_id}")
        end
      else
        get_proxy_sensors_by_role[role].dup
      end
    end
  end
end
