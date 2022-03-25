class Chef
    class Recipe
      def proxy_services()
        proxy_services  = {}
        node["redborder"]["services"].each { |k,v| proxy_services[k] = v if (v==true or v==false) } if !node["redborder"]["services"].nil?
        
        # changing default values in case of the user has modify them
        node["redborder"]["services"]["overwrite"].each { |k,v| proxy_services[k] = v if (v==true or v==false) } if !node["redborder"]["services"]["overwrite"].nil?
        
        return proxy_services
      end
    end
  end