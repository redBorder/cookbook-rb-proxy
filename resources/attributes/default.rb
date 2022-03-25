#Default attributes

#general
default["redborder"]["cdomain"] = "redborder.cluster"
default["redborder"]["organization_uuid"] = nil
default["redborder"]["organizations"] = []
default["redborder"]["locations"] = [
                                      "namespace", "namespace_uuid", "organization", "organization_uuid", \
                                      "service_provider", "service_provider_uuid", "deployment", \
                                      "deployment_uuid", "market", "market_uuid", "campus", "campus_uuid", \
                                      "building", "building_uuid", "floor", "floor_uuid"
                                    ]


#chef-client
default["chef-client"]["interval"] = 300
default["chef-client"]["splay"] = 100
default["chef-client"]["options"] = ""

#kafka
default["redborder"]["kafka"]["port"] = 9092
default["redborder"]["kafka"]["logdir"] = "/var/log/kafka"
default["redborder"]["kafka"]["host_index"] = 0

#zookeeper
default["redborder"]["zookeeper"]["zk_hosts"] = ""
default["redborder"]["zookeeper"]["port"] = 2181

# memory
default["redborder"]["memory_services"]    = {}
#default["redborder"]["memory_services"]["kafka"]     = {"count" => 150, "memory" => 0,"max_limit" => 2097152}
default["redborder"]["memory_services"]["kafka"]     = {"count" => 150, "memory" => 0,"max_limit" => 524288}
default["redborder"]["memory_services"]["zookeeper"] = {"count" => 20, "memory" => 0}
default["redborder"]["memory_services"]["chef-client"] = {"count" => 10, "memory" => 0}
default["redborder"]["memory_services"]["http2k"] = {"count" => 10, "memory" => 0}
default["redborder"]["memory_services"]["chef-server"] = {"count" => 10, "memory" => 0}
default["redborder"]["memory_services"]["snmp"] = {"count" => 5, "memory" => 0, "max_limit" => 10000 }
default["redborder"]["memory_services"]["redborder-monitor"] = {"count" => 5, "memory" => 0, "max_limit" => 20000 }
default["redborder"]["memory_services"]["f2k"] = { "count" => 40, "memory" => 0 }
default["redborder"]["memory_services"]["redborder-social"] = {"count" => 10, "memory" => 0 }
default["redborder"]["memory_services"]["redborder-nmsp"] = {"count" => 10, "memory" => 0 }
default["redborder"]["memory_services"]["n2klocd"] = {"count" => 10, "memory" => 0 }

default["redborder"]["services"] = {}
default["redborder"]["services"]["chef-client"]               = true
default["redborder"]["services"]["kafka"]                     = false
default["redborder"]["services"]["zookeeper"]                 = false
default["redborder"]["services"]["rb-monitor"]                = false
default["redborder"]["services"]["geoip"]                     = false
default["redborder"]["services"]["redborder-monitor"]         = true
default["redborder"]["services"]["redborder-scanner"]         = false
default["redborder"]["services"]["snmp"]                      = true
default["redborder"]["services"]["ntp"]                       = true
default["redborder"]["services"]["f2k"]                       = false
default["redborder"]["services"]["logstash"]                  = false
default["redborder"]["services"]["pmacct"]                    = false
default["redborder"]["services"]["rsyslog"]                   = true
default["redborder"]["services"]["redborder-social"]          = false
default["redborder"]["services"]["redborder-nmsp"]            = false
default["redborder"]["services"]["redborder-ale"]             = false
default["redborder"]["services"]["n2klocd"]                   = false
default["redborder"]["services"]["radiusd"]                   = false

default["redborder"]["systemdservices"]["chef-client"]            = ["chef-client"]
default["redborder"]["systemdservices"]["kafka"]                  = ["kafka"]
default["redborder"]["systemdservices"]["zookeeper"]              = ["zookeeper"]
default["redborder"]["systemdservices"]["geoip"]                  = ["geoip"]
default["redborder"]["systemdservices"]["redborder-monitor"]      = ["redborder-monitor"]
default["redborder"]["systemdservices"]["redborder-scanner"]      = ["redborder-scanner"]
default["redborder"]["systemdservices"]["snmp"]                   = ["snmpd"]
default["redborder"]["systemdservices"]["ntp"]                    = ["ntpd"]
default["redborder"]["systemdservices"]["f2k"]                    = ["f2k"]
default["redborder"]["systemdservices"]["logstash"]               = ["logstash"]
default["redborder"]["systemdservices"]["pmacct"]                 = ["sfacctd"]
default["redborder"]["systemdservices"]["rsyslog"]                = ["rsyslog"]
default["redborder"]["systemdservices"]["redborder-social"]       = ["redborder-social"]
default["redborder"]["systemdservices"]["redborder-nmsp"]         = ["redborder-nmsp"]
default["redborder"]["systemdservices"]["redborder-ale"]          = ["redborder-ale"]
default["redborder"]["systemdservices"]["n2klocd"]                = ["n2klocd"]
default["redborder"]["systemdservices"]["radiusd"]                = ["radiusd"]

