require_relative '../models/service.rb'

Service.create(service: 'echo', description: 'Sample delivery service', endpoint: 'http://localhost:9292/echo')
Service.create(service: 'beneficio300usd', description: 'Sample processing service', endpoint: 'http://localhost:9292/beneficio300usd')
Service.create(service: 'twilio', description: 'Sample delivery service', endpoint: 'http://localhost:9292/twilio')
Service.create(service: 'webhook', description: 'Sample delivery service', endpoint: 'http://localhost:9292/webhook')