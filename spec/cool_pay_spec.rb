require "spec_helper"

describe CoolPay do
  let(:client) { CoolPay.client }
  
  describe "#client" do
    context "client does not exist" do
      it "returns new cleint" do
        expect(CoolPay.client.class).to eq(CoolPay::Client)
      end
    end  
    context "client already exists" do
      it "returns current client" do
        expect(CoolPay.client).to eq(client)    
      end
    end
  end
end