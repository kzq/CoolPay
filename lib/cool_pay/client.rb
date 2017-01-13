require 'rest-client'
require 'ostruct'
require 'json'
module CoolPay
  class Client
    attr_accessor :username, :api_key, :currency
    attr_reader :token
    
    def initialze
      @currency = "GBP"
    end
    
    def login(options)
      @username, @api_key = options[:username], options[:api_key] 
      payload = {username: @username, apikey: @api_key}
      res = Resource.new("login")
      response = Request.send(res,payload)
      #puts ">>>>>>response.body=#{response.body}"     
      response_obj = Response.to_obj(response.body)
      @token = response_obj.token
      #puts ">>>>>@token=#{@token}"
      self
    end
    
    def make_payment(amount,recepient_id)
      payment = Payment.new(amount,@currency)
      payment.make(recepient_id,@token)    
    end
    
    def add_recipient(name)
      recipient = Recipient.new(name)
      recipient.add(@token)
    end
  end
  
  class Recipient
    attr_accessor :name
    attr_reader :id
    
    def initialize(name) 
      @name = name    
    end
    
    def add(token)
      payload, res = { recipient: {name: @name} }, Resource.new("recipients") 
      res.add_token(token)
      response = Request.send(res,payload)
      #puts ">>>>>response.body=#{response.body}"
      response_obj = Response.to_obj(response.body)
      response_obj.recipient
    end
  end
  
  class Payment
    def initialize(amount,currency)
      @amount, @currency = amount, currency ||= currency = "GBP"     
    end
    
    def make(recepient_id,token)
      payload, res = { payment: {amount: @amount, currency: @currency, recipient_id: recepient_id} }, Resource.new("payments") 
      #puts "payload=#{payload}"
      res.add_token(token)
      response = Request.send(res,payload)
      #puts ">>>>>response.body=#{response.body}"
      response_obj = Response.to_obj(response.body)
      response_obj.payment
    end
  end
  
  class Response
    def self.to_obj(response)
      JSON.parse(response, object_class: OpenStruct)
    end
  end
  
  class Request
    def self.send(resource, payload)
      #puts ">>>>>>>>>>>url=#{resource.url}"
      #puts ">>>>>>>>>>>headers=#{resource.headers}"
      RestClient.post resource.url, payload, resource.headers  
    end
  end
  
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