require 'dotenv/load'
require "sidekiq"
require "json"
require "net/http"
require_relative "../services/registered_services"
require_relative './dispatch_worker'

class ProcessWorker
  include Sidekiq::Worker
    
  def perform(id)
    #TODO: Leer desde el almacenamiento usando el id de acuerdo al patrón claim check (https://docs.microsoft.com/en-us/azure/architecture/patterns/claim-check)
    service = 'Beneficio300usd'
    payload = "{ }"
    p 'starting...'
    response = CallService(service, payload)
    #TODO: Actualizar en el almacenamiento con la infomación devuelta por el servicio
    DispatchWorker.perform_async(1)
  end

  #TODO: Usar método desde un módulo (process_worker.rb)
  def CallService(service, body)
    enpoint = URI.parse(RegisteredServices.LookUp(service))
    p enpoint.request_uri
    http = Net::HTTP.start(enpoint.host,enpoint.port)
    request = Net::HTTP::Post.new enpoint
    request.body = body
    http.request(request)
  end
end
