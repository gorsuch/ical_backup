#!/usr/bin/env ruby

require 'openssl'
require 'open-uri'
require 'yaml'

# hack to allow us to get around ssl cert verification
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

DATA_BASE_DIR = '/usr/local/ical_backup'

icals = YAML.load_file('/usr/local/etc/ical_backup.yaml')

icals.each do |k,v|
  data = open(v).read
  backup_file_name = "#{k}.#{Time.now.strftime("%Y%m%d")}.ical"
  File.open(File.join(DATA_BASE_DIR,backup_file_name), 'w') do |f|
    f << data
  end
end
