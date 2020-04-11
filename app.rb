require 'sinatra'
require 'json'
require_relative './workers/enqueue_worker'

class App < Sinatra::Base
  post '/' do
    if params["service"].present? and params["payload"].present? and params["delivery"].present?
    begin
        message = { service: params["service"], payload: params["payload"], delivery: params["delivery"]}
        EnqueueWorker.perform_async(message)
        resp = { message: 'Ok', status: 200}
    rescue => exception 
        p exception
        resp = { message: 'Server error', status: 500}
    end
    else
      resp = { message: 'Bad request', status: 400}
    end
    
    content_type :json
    halt status, resp.to_json
  end

end

#Endpoint principal de ejemplo