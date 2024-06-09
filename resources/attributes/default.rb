# require 'set' TODO: refactor to this

# general
default['redborder']['cdomain'] = 'redborder.cluster'
default['redborder']['organization_uuid'] = nil
default['redborder']['organizations'] = []
default['redborder']['locations'] = %w(namespace namespace_uuid organization organization_uuid service_provider service_provider_uuid deployment deployment_uuid market market_uuid campus campus_uuid building building_uuid floor floor_uuid)

default['redborder']['proxy']['insecure'] = true

# chef-client
default['chef-client']['interval'] = 300
default['chef-client']['splay'] = 100
default['chef-client']['options'] = ''

# kafka
default['redborder']['kafka']['port'] = 9092
default['redborder']['kafka']['logdir'] = '/var/log/kafka'
default['redborder']['kafka']['host_index'] = 0

# zookeeper
default['redborder']['zookeeper']['zk_hosts'] = ''
default['redborder']['zookeeper']['port'] = 2181

# memory
default['redborder']['memory_services'] = {}
default['redborder']['memory_services']['kafka'] = { 'count': 150, 'memory': 0, 'max_limit': 524288 }
default['redborder']['memory_services']['zookeeper'] = { 'count': 20, 'memory': 0 }
default['redborder']['memory_services']['chef-client'] = { 'count': 10, 'memory': 0 }
default['redborder']['memory_services']['http2k'] = { 'count': 10, 'memory': 0 }
default['redborder']['memory_services']['chef-server'] = { 'count': 10, 'memory': 0 }
default['redborder']['memory_services']['snmp'] = { 'count': 5, 'memory': 0, 'max_limit': 10000 }
default['redborder']['memory_services']['redborder-monitor'] = { 'count': 5, 'memory': 0, 'max_limit': 20000 }
default['redborder']['memory_services']['f2k'] = { 'count': 40, 'memory': 0 }
default['redborder']['memory_services']['redborder-nmsp'] = { 'count': 10, 'memory': 0 }
default['redborder']['memory_services']['n2klocd'] = { 'count': 10, 'memory': 0 }
default['redborder']['memory_services']['k2http'] = { 'count': 10, 'memory': 0 }

# exclude mem services, setting memory to 0 for each.
default['redborder']['excluded_memory_services'] = ['chef-client']

default['redborder']['services'] = {}
default['redborder']['services']['chef-client'] = true
default['redborder']['services']['kafka'] = true
default['redborder']['services']['zookeeper'] = true
default['redborder']['services']['rb-monitor'] = true
default['redborder']['services']['redborder-monitor'] = true
default['redborder']['services']['redborder-scanner'] = true
default['redborder']['services']['snmp'] = true
default['redborder']['services']['f2k'] = true
default['redborder']['services']['logstash'] = true
default['redborder']['services']['pmacct'] = true
default['redborder']['services']['rsyslog'] = true
default['redborder']['services']['redborder-nmsp'] = true
default['redborder']['services']['redborder-ale'] = true
default['redborder']['services']['n2klocd'] = true
default['redborder']['services']['radiusd'] = true
default['redborder']['services']['k2http'] = true
default['redborder']['services']['redborder-exporter'] = true

default['redborder']['systemdservices']['chef-client'] = ['chef-client']
default['redborder']['systemdservices']['kafka'] = ['kafka']
default['redborder']['systemdservices']['zookeeper'] = ['zookeeper']
default['redborder']['systemdservices']['redborder-monitor'] = ['redborder-monitor']
default['redborder']['systemdservices']['redborder-scanner'] = ['redborder-scanner']
default['redborder']['systemdservices']['snmp'] = ['snmpd']
default['redborder']['systemdservices']['f2k'] = ['f2k']
default['redborder']['systemdservices']['logstash'] = ['logstash']
default['redborder']['systemdservices']['pmacct'] = ['sfacctd']
default['redborder']['systemdservices']['rsyslog'] = ['rsyslog']
default['redborder']['systemdservices']['redborder-nmsp'] = ['redborder-nmsp']
default['redborder']['systemdservices']['redborder-ale'] = ['redborder-ale']
default['redborder']['systemdservices']['n2klocd'] = ['n2klocd']
default['redborder']['systemdservices']['radiusd'] = ['radiusd']
default['redborder']['systemdservices']['k2http'] = ['k2http']
default['redborder']['systemdservices']['redborder-exporter'] = ['rb-exporter']
