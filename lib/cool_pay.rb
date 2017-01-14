$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'forwardable'
require 'cool_pay/client'

module CoolPay

  class Error < RuntimeError; end
  class AuthenticationError < Error; end  
  class ConfigurationError < Error 
    def initialize(key)
      super "missing key #{key}"
    end
  end
  
  class << self
    extend Forwardable
    
    def_delegators :client, :login, :username, :api_key, :token, :add_recipient, :currency, :make_payment
    def_delegators :client, :username=, :api_key=
    
    def client
      @client ||= CoolPay::Client.new
    end
    
  end 
  
end