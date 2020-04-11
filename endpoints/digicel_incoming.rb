require 'sinatra'
require 'json'
require_relative '../workers/enqueue_worker'

class DigicelIncoming < Sinatra::Base
  post '/' do
    body = JSON.parse(request.body.read)
    begin
        payload = {dui: body['message'], phone: body['mobile']}
        message = { service: 'beneficio300usd', payload: payload, delivery: 'echo'}
        EnqueueWorker.perform_async(message)
        resp = { message: 'Ok', status: 200}
    rescue => exception 
        p exception
        resp = { message: 'Server error', status: 500}
    end
    
    content_type :json
    halt status, resp.to_json
  end

end

#Endpoint digixcel de ejemplo