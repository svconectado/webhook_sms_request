require 'dotenv/load'
require "sidekiq"
require "json"
require "net/http"
require_relative "../services/registered_services"
require_relative "../models/message"
require 'sinatra/activerecord'

class DispatchWorker
  include Sidekiq::Worker

  def perform(id)
    msg = Message.find(id)
    body = {"payload" => msg.payload, "response" => msg.response}
    self.CallService(msg.delivery, "#{body}")
    msg.destroy
  end

  #TODO: Usar este método desde un módulo (dispatch_worker.rb)
  def CallService(service, body)
    enpoint = URI.parse(RegisteredServices.LookUp(service))
    http = Net::HTTP.start(enpoint.host,enpoint.port)
    request = Net::HTTP::Post.new enpoint
    request.body = body
    http.request(request)
  end
end
