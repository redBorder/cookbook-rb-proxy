#--------------------------Geoipupdate-------------------------#
cron_d 'geoipupdate' do
  comment "Update GeoIP and GeoLite Databases twice a week"
  action :create
  minute '41'
  hour   '17'
  weekday '1,4'
  retries 2
  ignore_failure true
  command "/usr/local/bin/geoipupdate -v"
end