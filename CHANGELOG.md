cookbook-rb-proxy CHANGELOG
===============

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
