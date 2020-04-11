require_relative '../models/service.rb'

class RegisteredServices
    
    #TODO: Implementar patrón cache aside con base de datos y redis (https://docs.microsoft.com/en-us/azure/architecture/patterns/cache-aside)

    def RegisteredServices.LookUp(name)
        svc = Service.find_by :service => name
        if svc
            return svc.endpoint
        else
            raise Exception.new "Unknown Service"
        end
    end
    
end