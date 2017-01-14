module CoolPay
  class Request
    def initialize(timeout)
      @timeout = timeout 
    end
    def send(resource, values)
      begin
        RestClient.post resource.url, values.to_json, resource.headers
      rescue => e
        response = e.response
        handle_status_code(response.code,response.body)
      end  
    end
    
    def handle_status_code(code, body)
      case code
      when 200, 202
        return
      when 400
        raise Error, "Bad request: #{body}"
      when 401
        raise AuthenticationError, body
      when 404
        raise Error, "404 Not found"
      else
        raise Error, "Unknown error (status code #{code}): #{body}"
      end
    end
  end
end  