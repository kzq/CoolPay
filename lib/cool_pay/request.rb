module CoolPay
  class Request
    def initialize(method,timeout)
      @method, @timeout = method, timeout 
    end
    def send(resource, payload)
      puts ">>>>>>>>>>>url=#{resource.url}"
      puts ">>>>>>>>>>>headers=#{resource.headers}"
      begin
        RestClient::Request.execute(method: @method.to_sym, url: resource.url, headers: resource.headers, payload: payload, timeout: @timeout)
        #RestClient.post resource.url, payload, resource.headers
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