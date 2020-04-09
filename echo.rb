require 'sinatra'
require 'json'

class Echo < Sinatra::Base
  post '/' do
    p request.body.read
    resp = { message: 'Ok', status: 200}  
    content_type :json
    halt status, resp.to_json
  end
end

#Servicio de delivery de ejemplo