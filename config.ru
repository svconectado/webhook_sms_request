# config.ru
require 'dotenv/load'
require 'active_support/security_utils'
require './app'
require 'sidekiq'
require 'sidekiq/web'

#ejemplos
require_relative './endpoints/echo'
require_relative './endpoints/beneficio300usd'


if ENV['RACK_ENV'] == 'production'
  redis_hash = {
    url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}",
    password: ENV['REDIS_PASSWORD'].to_s
  }
else
  redis_hash = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

Sidekiq.configure_client do |config|
  config.redis = redis_hash
end

Sidekiq::Web.use Rack::Auth::Basic, 'Admin' do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])
  ) & ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD'])
  )
end

run Rack::URLMap.new(
  '/sidekiq' => Sidekiq::Web, 
  '/' => App,
  '/echo' => Echo,
  '/beneficio300usd' => Beneficio300usd
)