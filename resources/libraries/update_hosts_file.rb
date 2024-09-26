module RbProxy
  module Helpers
    def get_setup_ip
      rb_init_conf = YAML.load_file('/etc/redborder/rb_init_conf.yml')
      rb_init_conf['cloud_address']
    end

    def get_external_databag_services
      Chef::DataBag.load('rBglobal').keys.grep(/^ipvirtual-external-/).map { |bag| bag.sub('ipvirtual-external-', '') }
    end

    def read_hosts_file
      hosts_hash = Hash.new { |hash, key| hash[key] = [] }
      File.readlines('/etc/hosts').each do |line|
        next if line.strip.empty? || line.start_with?('#')
        values = line.split(/\s+/)
        ip = values.shift
        services = values
        hosts_hash[ip].concat(services).uniq!
      end
      hosts_hash
    end

    def update_hosts_file
      setup_ip = get_setup_ip
      running_services = node['redborder']['systemdservices'].values.flatten if node['redborder']['systemdservices']
      databags = get_external_databag_services
      hosts_hash = read_hosts_file

      # Hash where services (from databag) are grouped by ip
      grouped_virtual_ips = Hash.new { |hash, key| hash[key] = [] }
      databags.each { |bag_serv| grouped_virtual_ips[setup_ip] << "#{bag_serv}" }
      running_services.each { |serv| grouped_virtual_ips['127.0.0.1'] << "#{serv}" }

      # Group services
      grouped_virtual_ips.each do |_new_ip, new_services|
        new_services.each do |new_service|
          # Remove suffix and get services
          service_key = new_service.split('.').first
          hosts_hash.each { |_ip, services| services.delete_if { |service| service.split('.').first == service_key } }

          # Add running services to localhost
          if running_services.include?(new_service)
            hosts_hash['127.0.0.1'] << "#{new_service}.service"
            next
          end
          hosts_hash[setup_ip] << "#{new_service}.service"
          hosts_hash[setup_ip] << "#{new_service}.#{node['redborder']['cdomain']}"
        end
      end

      # Prepare the lines for the hosts file
      hosts_entries = []
      hosts_hash.each do |ip, services|
        format_entry = format('%-18s%s', ip, services.join(' '))
        hosts_entries << format_entry unless services.empty?
      end
      hosts_entries
    end
  end
end
