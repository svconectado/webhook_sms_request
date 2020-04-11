require "json"
require "net/http"
require 'sinatra/activerecord'
require_relative "../models/message"

class EnqueueWorker
  include Sidekiq::Worker
    
  def perform(msg)
    Message.save(msg['service'], msg['payload'], msg['delivery'])
  end

end
