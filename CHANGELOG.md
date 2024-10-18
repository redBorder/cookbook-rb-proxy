cookbook-rb-proxy CHANGELOG
===============

## 2.0.0

  - Miguel Negron
    - [6e7bc6a] Add sudoers config

## 1.0.1

  - Miguel Negrón
    - [7205709] Add pre and postun to clean the cookbook

## 1.0.0

  - Miguel Negrón
    - [64e7db8] Merge pull request #47 from redBorder/bugfix/18716_remove_sync_address_from_hosts_file
    - [2a15362] Merge pull request #43 from redBorder/development
    - [b271475] Merge pull request #42 from redBorder/development
    - [c939764] Merge pull request #36 from redBorder/development
    - [a88941c] Merge pull request #33 from redBorder/development
    - [91f880b] Improvement/fix lint (#32)
    - [6917897] Merge pull request #31 from redBorder/development
    - [569bdd3] Merge pull request #30 from redBorder/bugfix/#15141_remove_geoip_from_service_list
  - Miguel Negrón
    - [64e7db8] Merge pull request #47 from redBorder/bugfix/18716_remove_sync_address_from_hosts_file
    - [08d7c8e] Simplify code
    - [2a15362] Merge pull request #43 from redBorder/development
    - [b271475] Merge pull request #42 from redBorder/development
    - [c939764] Merge pull request #36 from redBorder/development
    - [a88941c] Merge pull request #33 from redBorder/development
    - [91f880b] Improvement/fix lint (#32)
    - [6917897] Merge pull request #31 from redBorder/development
    - [208cb02] Bump version
    - [569bdd3] Merge pull request #30 from redBorder/bugfix/#15141_remove_geoip_from_service_list
  - nilsver
    - [cf63684] fix lint
    - [20f4348] fix duplication bug
    - [7a174c5] fix lint
    - [f1d532e] update hosts file
    - [b329547] Release 0.4.0
    - [c1cdf71] Release 0.4.0
    - [1e3bb37] Merge pull request #39 from redBorder/feature/18019_add_chronyd_cookbook
    - [cc8b9a6] update format
    - [d7bf449] update hosts file
    - [e1272bb] add check for monitor configuration pipelines
    - [6185bfa] fix logstash not running when pipelines empty
    - [08f57da] fix logstash not running when pipelines empty
    - [bbb37f7] disable freeradius
    - [ec5d379] update configure.rb
    - [c35b312] logstash should not be running when there are no pipelines
  - JuanSheba
    - [630cc1d] Release 0.6.0
    - [45c4856] Release 0.3.0
    - [b80305e] Release 0.2.5
  - Juan Soto
    - [2629e25] Merge pull request #46 from redBorder/feature/#18681_split_traffic_with_logstash
    - [c521a5f] Update CHANGELOG.md
    - [7338e9b] Update CHANGELOG.md
    - [48f3636] Update CHANGELOG.md
    - [ad927c6] Merge pull request #34 from redBorder/bugfix/17238_logstash_not_running_when_no_pipelines
    - [5e2004d] Merge pull request #37 from redBorder/feature/add_clamav
    - [9eeef01] Merge pull request #35 from redBorder/bugfix/17578_disable_freeradius
  - David Vanhoucke
    - [7dadc5e] use descrfptive name
    - [964e8d0] remove blank line
    - [a686df0] add method to activate the split of the traffic through logstash
  - JPeraltaNic
    - [1effbed] Merge pull request #45 from redBorder/development
    - [546fc0d] Release 0.5.1
    - [3df81bb] Merge pull request #44 from redBorder/bugfix/18586_no_sensors_in_proxy
    - [20616f2] Merge branch 'master' into bugfix/18586_no_sensors_in_proxy
    - [acd32dc] Merge pull request #41 from redBorder/feature/18393_update_hosts_file
    - [982e2b0] Merge branch 'master' into feature/18393_update_hosts_file
    - [4a64c6d] Update CHANGELOG.md
  - Daniel Castro
    - [8645664] get rid of unnecesary attributes
    - [22fb6a9] fix chef node attribute
    - [c3c2fd3] 18586 send node info to redborder-monitor
    - [794a4a6] Release 0.5.0
    - [b85f706] Release 0.4.1 ammend
    - [26855b5] Release 0.4.1
    - [2d14d08] Merge pull request #40 from redBorder/feature/#16519_enable_ale_if_sensors
  - Miguel Álvarez
    - [8a7c051] Update configure.rb
    - [4cfaf41] Update default.rb
    - [49a3825] Update configure.rb
    - [2cd3e11] Update default.rb
  - Miguel Alvarez
    - [2daff03] Add chronyd cookbook
    - [56ef242] Add chronyd cookbook
    - [3f38047] Add clamAV
  - Luis Blanco
    - [cb38a36] disable service ale by default
    - [bbaff20] action based on if there is any ale sensor
    - [2bda259] Merge pull request #38 from redBorder/development
    - [e02fe7a] remove from the service list. Not remove, always add in configuration
  - vimesa
    - [8f950d5] Release 0.2.4
  - Miguel Negrón
    - [208cb02] Bump version

## 0.6.0

  - David Vanhoucke
    - [7dadc5e] use descrfptive name
    - [964e8d0] remove blank line
    - [a686df0] add method to activate the split of the traffic through logstash

## 0.5.1

  - Daniel Castro
    - [8645664] get rid of unnecesary attributes
    - [c3c2fd3] send node info to redborder-monitor

## 0.5.0

  - nilsver
    - [cc8b9a6] update format
    - [d7bf449] update hosts file
  - Luis Blanco
    - [cb38a36] disable service ale by default
    - [bbaff20] action based on if there is any ale sensor

## 0.4.0

  - Miguel Alvarez
    - [56ef242] Add chronyd cookbook

## 0.3.0

  - nilsver
    - [e1272bb] add check for monitor configuration pipelines
    - [6185bfa], [08f57da] fix logstash not running when pipelines empty
    - [ec5d379] update configure.rb
    - [c35b312] logstash should not be running when there are no pipelines
  - Miguel Alvarez
    - [2be5b59] Fix configure clamscan
    - [2e0b86b] Add clamav

## 0.2.5

  - nilsver
    - [bbb37f7] disable freeradius

## 0.2.4

  - Miguel Negrón
    - [91f880b] Improvement/fix lint (#32)

## 0.2.3

  - Luis Blanco
    - [e02fe7a] remove from the service list. Not remove, always add in configuration

## 0.2.2

  - David Vanhoucke
    - [28ae7e2] add temporary variables in node.run_state
  - Miguel Negrón
    - [3e930e8] Update README.md
    - [c7e880b] Update rpm.yml

## 0.2.1

  - Miguel Negrón
    - [a72760b] Update metadata.rb
    - [76d035a] Add full kernel release info in motd
  - David Vanhoucke
    - [6484209] change rb-exporter service name

## 0.2.0

  - Miguel Negrón
    - [1b3f547] Add configure common cookbook call (#23)

## 0.1.6

  - Miguel Álvarez
    - [fe69f8f] Update memory_services.rb
    - [86466b0] Update prepare_system.rb
    - [47c06c8] Clean comments
    - [48fe519] Update prepare_system.rb
    - [8d08754] Update default.rb

## 0.1.5

  - David Vanhoucke
    - [b5de2fb] add rb_exporter service in redborder proxy

## 0.0.1
- [Miguel Negrón] - Initial release of proxy
