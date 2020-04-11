require 'dotenv/load'
require "net/http"
require "json"
require 'sinatra'
require_relative './endpoint_base'

class Beneficio300usd < EndpointBase
  post '/' do
    payload = JSON.parse(request.body.read)
    validate(payload, ['dui'])
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
    body = response.body
    #TODO: Procesar respuesta
    content_type :json
    halt status, body
  end
end

#Servicio de procesamiento de ejemplo