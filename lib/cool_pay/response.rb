module CoolPay
  class Response
    attr_reader :body, :code, :headers
    
    def initialize(response)
      @body, @code, @headers= response.body, response.code, response.headers
      puts ">>>>>>>>>>response=#{response}"     
      puts ">>>>>>>>>>response body=#{@body}"
    end
    
    def to_obj
      JSON.parse(@body, object_class: OpenStruct)
    end
  end
end