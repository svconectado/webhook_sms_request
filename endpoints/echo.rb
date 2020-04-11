require 'sinatra'
require 'json'

class Echo < Sinatra::Base
  post '/' do
    body = request.body.read
    #echoing...
    p body
    resp = body
    content_type :json
    halt status, resp
  end
end

#Servicio de delivery de ejemplo