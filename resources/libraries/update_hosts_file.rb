module RbProxy
  module Helpers
    require 'resolv'

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
      manager_registration_ip = managerToIp(node['redborder']['manager_registration_ip']) if node['redborder'] && node['redborder']['manager_registration_ip']

      return unless manager_registration_ip

      running_services = node['redborder']['systemdservices'].values.flatten if node['redborder']['systemdservices']
      databags = Chef::DataBag.load('rBglobal').keys.grep(/^ipvirtual-external-/).map { |bag| bag.sub('ipvirtual-external-', '') }
      hosts_hash = read_hosts_file

      # Hash where services (from databag) are grouped by ip
      grouped_virtual_ips = Hash.new { |hash, key| hash[key] = [] }
      databags.each { |bag_serv| grouped_virtual_ips[manager_registration_ip] << "#{bag_serv}" }
      running_services.each { |serv| grouped_virtual_ips['127.0.0.1'] << serv }

      # Group services
      grouped_virtual_ips.each do |new_ip, new_services|
        new_services.each do |new_service|
          # Avoids having duplicate services in the list
          service_key = new_service.split('.').first
          hosts_hash.each do |_ip, services|
            services.delete_if { |service| service.split('.').first == service_key }
          end

          # Add running services to localhost
          if new_ip == '127.0.0.1' && running_services.include?(new_service)
            hosts_hash['127.0.0.1'] << "#{new_service}.service"
            next
          end
          hosts_hash[manager_registration_ip] << "#{new_service}.service"
          hosts_hash[manager_registration_ip] << "#{new_service}.#{node['redborder']['cdomain']}"
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

    def managerToIp(str)
      ipv4_regex = /\A(\d{1,3}\.){3}\d{1,3}\z/
      ipv6_regex = /\A(?:[A-Fa-f0-9]{1,4}:){7}[A-Fa-f0-9]{1,4}\z/
      dns_regex = /\A[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\z/

      return str if str =~ ipv4_regex || str =~ ipv6_regex

      if str =~ dns_regex
        begin
          return Resolv.getaddress(str).to_s
        rescue Resolv::ResolvError
          return nil
        end
      end
    end
  end
end
