require 'dotenv/load'
require "sidekiq"
require "json"
require "net/http"
require_relative "../services/registered_services"
require_relative "./process_worker"

class EnqueueWorker
  include Sidekiq::Worker
    
  def perform(message)
    #TODO: Guardar en algún almacenamiento persistente implementando el patrón claim check (https://docs.microsoft.com/en-us/azure/architecture/patterns/claim-check)
    ProcessWorker.perform_async(1)
  end

end
