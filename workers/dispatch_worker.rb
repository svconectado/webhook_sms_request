require 'dotenv/load'
require "sidekiq"
require "json"
require "net/http"
require_relative "../services/registered_services"

class DispatchWorker
  include Sidekiq::Worker

  def perform(id)
    #TODO: Leer desde el almacenamiento usando el id de acuerdo al patrón claim check (https://docs.microsoft.com/en-us/azure/architecture/patterns/claim-check)
    service = "echo"
    response = "Messaged Processed!"
    self.CallService(service, response)
    
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
