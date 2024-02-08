name            'rb-proxy'
maintainer      'Miguel Negron'
maintainer_email 'manegron@redborder.com'
license          'All rights reserved'
description      'Installs/Configures redborder proxy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

depends 'rb-selinux'
depends 'zookeeper'
depends 'kafka'
depends 'geoip'
depends 'snmp'
depends 'rbmonitor'
depends 'rbscanner'
depends 'f2k'
depends 'pmacct'
depends 'logstash'
depends 'rsyslog'
depends 'rbnmsp'
depends 'rbale'
depends 'n2klocd'
#depends 'freeradius'
#depends 'k2http'
#depends 'ohai'
depends 'rbcgroup'
