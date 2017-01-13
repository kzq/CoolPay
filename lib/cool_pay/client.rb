require 'rest-client'
require 'ostruct'
require 'json'
require 'cool_pay/request'
require 'cool_pay/resource'
require 'cool_pay/response'
module CoolPay
  class Client
    attr_accessor :username, :api_key, :currency
    attr_reader :token
    
    def initialze
      @currency = "GBP"
    end
    
    def login(options)
      @username, @api_key = options.values_at(:username, :api_key)
      raise ConfigurationError, :username unless @username
      raise ConfigurationError, :apikey unless @api_key
      payload = {username: @username, apikey: @api_key}
      resource = Resource.new("login")
      #request = Request.new("post",10)
      #response = Response.new(request.send(resource,payload))
      #puts ">>>>>>response.body=#{response.body}"     
      #response_object = response.to_obj
      #@token = response_object.token
      @token = "5aaac2bc-126a-48bb-a941-36d9437b5a45"
      puts ">>>>>@token=#{@token}"
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
      payload, resource = { recipient: {name: @name} }, Resource.new("recipients") 
      resource.add_token(token)
      request = Request.new("post",10)
      response = Response.new(request.send(resource,payload))
      #puts ">>>>>>response.body=#{response.body}" 
      response_object = response.to_obj
      response_object.recipient
    end
  end
  
  class Payment
    def initialize(amount,currency)
      @amount, @currency = amount, currency ||= currency = "GBP"     
    end
    
    def make(recepient_id,token)
      payload, resource = { payment: {amount: @amount, currency: @currency, recipient_id: recepient_id} }, Resource.new("payments") 
      resource.add_token(token)
      request = Request.new("post",10)
      response = Response.new(request.send(resource,payload))
      puts ">>>>>>response.body=#{response.body}" 
      response_object = response.to_obj
      response_object.payment
    end
  end
end