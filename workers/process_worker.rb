require "sidekiq"
require "json"
require "net/http"
require_relative "../services/registered_services"
require_relative './dispatch_worker'
require_relative "../models/message"
require 'sinatra/activerecord'

class ProcessWorker
  include Sidekiq::Worker
    
  def perform(id)
    msg = Message.find(id)
    if !msg
      raise Exception.new "Missing row: #{id}"
    end
    response = CallService(msg.service, msg.payload)
    msg.update(response: response.body)
    DispatchWorker.perform_async(id)
  end

  #TODO: Usar método desde un módulo (process_worker.rb)
  def CallService(service, body)
    enpoint = URI.parse(RegisteredServices.LookUp(service))
    http = Net::HTTP.start(enpoint.host,enpoint.port)
    request = Net::HTTP::Post.new enpoint
    request.body = body
    http.request(request)
  end
end
