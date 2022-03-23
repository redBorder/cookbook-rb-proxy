module Rb_proxy
    module Helpers
        def joinHostArray2port(hosts, port)
            hosts.map { |host|
                host << ":" << port.to_s
            }
            return hosts
        end
    end
end