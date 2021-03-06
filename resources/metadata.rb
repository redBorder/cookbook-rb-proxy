name            'rb-proxy'
maintainer      'Miguel Negron'
maintainer_email 'manegron@redborder.com'
license          'All rights reserved'
description      'Installs/Configures redborder proxy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.4'

depends 'zookeeper'
depends 'kafka'
depends 'geoip'
depends 'snmp'
depends 'rbmonitor'
depends 'rbscanner'
depends 'ntp'
depends 'f2k'
depends 'pmacct'
depends 'logstash'
depends 'rsyslog'
depends 'rbsocial'
depends 'rbnmsp'
depends 'rbale'
depends 'n2klocd'
depends 'freeradius'
depends 'k2http'
