class Chef
  class Recipe
    def proxy_services
      proxy_services = {}
      if node['redborder']['services']
        node['redborder']['services'].each do |k, v|
          if v == true || v == false
            proxy_services[k] = v
          end
        end
      end

      # changing default values in case of the user has modify them
      if node['redborder']['services']['overwrite']
        node['redborder']['services']['overwrite'].each do |k, v|
          if v == true || v == false
            proxy_services[k] = v
          end
        end
      end

      proxy_services
    end
  end
end
