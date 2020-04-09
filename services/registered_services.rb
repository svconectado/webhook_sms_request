class RegisteredServices
    
    #TODO: Implementar patrón cache aside con base de datos y redis (https://docs.microsoft.com/en-us/azure/architecture/patterns/cache-aside)
    @@services = { "Beneficio300usd" => "http://localhost:9292/beneficio300usd", "echo" => "http://localhost:9292/echo" }

    def RegisteredServices.LookUp(name)
        service = @@services[name]
        if service  
            return service
        else
            raise Exception.new "Unknown Service"
        end
    end
    
end