require 'spec_helper'

describe CoolPay::Client do
  before :each do
      @client = CoolPay::Client.new
  end
  
  let(:client) { @client.login(username: "username",api_key: "api_key") } 
  
  it 'should be preconfigured for currency GBP' do
    expect(@client.currency).to eq("GBP")
  end
  
  describe "#login" do
    it "raises exception if username is not configured" do
        expect {
          @client.login(username:nil,api_key: "1223456788")
        }.to raise_error(CoolPay::ConfigurationError)
    end
    
    it "raises exception if api_key is not given" do
        expect {
          @client.login(username: "username",api_key: nil)
        }.to raise_error(CoolPay::ConfigurationError)
    end
    
    it 'sets token and returns self' do
         response = '{"token":"e815858f-e670-445b-b3c2-bbb6cf1586cc"}'
         stub_request(:post, "https://coolpay.herokuapp.com/api/login").
         with(:body => {"apikey"=>"api_key", "username"=>"username"},
              :headers => {"Content-Type"=> "application/json"}).
         to_return(:status => 200, :body => response)
          expect(@client.login(username: "username",api_key: "api_key")).to be_kind_of(CoolPay::Client)
          expect(client.username).to eq(@client.username)
          expect(client.api_key).to eq(@client.api_key)
          expect(client.token).to eq("e815858f-e670-445b-b3c2-bbb6cf1586cc")
    end
  end
  
  describe "#add_recipient" do
    it "adds recipient" do
      token = "e815858f-e670-445b-b3c2-bbb6cf1586cc"
      response = '{"recipient":{"name":"Ben Barker","id":"83c82172-8127-4c25-91db-0832cfa682fe"}}'
      stub_request(:post, "https://coolpay.herokuapp.com/api/recipients").
         with(:body => '{"recipient":{"name":"Ben Barker"}}',
              :headers => {"Content-Type"=> "application/json"}).
         to_return(:status => 200, :body => response)
      recipient = @client.add_recipient("Ben Barker")
      expect(recipient.name).to eq("Ben Barker")
      expect(recipient.id).to eq("83c82172-8127-4c25-91db-0832cfa682fe")  
    end
  end
  
  describe "#make_payment" do
    it "makes payment" do
      response = '{"payment":{"status":"processing","recipient_id":"83c82172-8127-4c25-91db-0832cfa682fe","id":"37b04854-6edf-481f-9794-a5f220c259c4","currency":"GBP","amount":"10.5"}}'
      stub_request(:post, "https://coolpay.herokuapp.com/api/payments").
         with(:body => "{\"payment\":{\"amount\":10.5,\"currency\":\"GBP\",\"recipient_id\":\"83c82172-8127-4c25-91db-0832cfa682fe\"}}",
              :headers => {"Content-Type"=> "application/json"}).
         to_return(:status => 200, :body => response)
      payment = @client.make_payment(10.5,"83c82172-8127-4c25-91db-0832cfa682fe")
      expect(payment.amount).to eq("10.5")
      expect(payment.recipient_id).to eq("83c82172-8127-4c25-91db-0832cfa682fe")  
    end    
  end
end  