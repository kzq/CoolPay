require 'bundler/setup'
Bundler.setup
require 'webmock/rspec'
require 'cool_pay'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    WebMock.reset!
    WebMock.disable_net_connect!(:allow_localhost => true)
  end
end