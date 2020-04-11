require 'sinatra'
require 'json'
require "net/http"
require_relative './endpoint_base'

class Webhook < EndpointBase
  post '/' do
    body = request.body.read
    payload = body['payload']
    validate(payload, ['url'])
    response = body['response']
    url = payload['url']
    enpoint = URI.parse(url)
    http = Net::HTTP.start(enpoint.host, enpoint.port,
      :use_ssl => enpoint.scheme == 'https')
    request = Net::HTTP::Get.new enpoint
    request.body = response
    response = http.request(request)
    resp = response.body
    content_type :json
    halt status, resp
  end
end

#Servicio de delivery de ejemplo