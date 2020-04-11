require "json"
require 'sinatra'

class EndpointBase < Sinatra::Base
  def validate(payload, params)
    params.each do |param|
      if !payload[param]
        raise Exception.new "Missing parameter: #{param}"
      end
    end
  end
end
