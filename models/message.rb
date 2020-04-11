require "sidekiq"
require_relative "../workers/process_worker"

class Message < ActiveRecord::Base
  self.table_name = 'messages'

  after_create :process_with_sidekiq

  def process_with_sidekiq
    # Delay de 1 segundo para permitir que el registro ingrese a la base antes de procesarlo
    ProcessWorker.perform_in(1.seconds, self.id)
  end
  
  def self.save(service, payload, delivery)
    Message.create(service: service, payload: payload, delivery: delivery)
  end
end
  