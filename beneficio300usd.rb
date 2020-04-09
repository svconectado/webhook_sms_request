require 'sinatra'
require 'json'

class Beneficio300usd < Sinatra::Base
  post '/' do
    p request.body.read
    resp = { message: 'Ok', status: 200}  
    content_type :json
    halt status, resp.to_json
  end
end

#Servicio de procesamiento de ejemplo