require 'sinatra'
require 'json'
require_relative './endpoint_base'
require_relative "../services/twilio_sms"

class TwilioDelivery < EndpointBase
  post '/' do
    body = request.body.read
    payload = body['payload']
    validate(payload, ['phone'])
    phone = payload['phone']
    response = body['response']
    resp=TwilioSms.send_sms(sms_request.phone, sms)
    content_type :json
    halt status, resp
  end
end

#Servicio de delivery de ejemplo