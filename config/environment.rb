require 'bundler'
Bundler.require
db_config = YAML.load_file('config/database.yml')
puts "======================================> db_config line value #{db_config.inspect}"
ActiveRecord::Base.establish_connection(db_config[ENV['RACK_ENV']])
