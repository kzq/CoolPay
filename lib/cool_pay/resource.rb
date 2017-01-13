module CoolPay
  class Resource
    attr_accessor :url, :headers
    
    def initialize(endpoint)
      @url, @headers = api_url + endpoint, default_header
    end
    
    def api_url
      'https://coolpay.herokuapp.com/api/'    
    end
    
    def default_header
      {:content_type => 'application/json'}
    end
    
    def add_token(token)
      @headers=@headers.merge(authorization: "Bearer #{token}")  
    end
  end
end