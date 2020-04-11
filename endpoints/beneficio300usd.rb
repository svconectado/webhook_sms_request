require 'dotenv/load'
require "net/http"
require "json"
require 'sinatra'

require_relative "../services/twilio_sms"

class Beneficio300usd < Sinatra::Base
  post '/' do
    payload = JSON.parse(request.body.read)
    dui = payload['dui']
    read_timeout = ENV['SCRAPPER_READ_TIMEOUT'].to_i 
    open_timeout = ENV['SCRAPPER_OPEN_TIMEOUT'].to_i
    enpoint = URI.parse("#{ENV['SCRAPPER_SERVICE']}/#{dui}")
    http = Net::HTTP.start(enpoint.host, enpoint.port,
      :use_ssl => enpoint.scheme == 'https',
      :read_timeout => read_timeout,
      :open_timeout => open_timeout)
    request = Net::HTTP::Get.new enpoint
    response = http.request(request)
    resp = response.body
    content_type :json
    halt status, resp
  end
end

#Servicio de procesamiento de ejemplo