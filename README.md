# CoolPay API Wrapper
------
**Scenario** 

Coolpay is a new company that allows to easily send money to friends through their API. You work for Fakebook, a successful social network. You’ve been tasked to integrate Coolpay inside Fakebook. A/B tests show that users prefer to receive money than pokes! You can find Coolpay documentation here: http://docs.coolpayapi.apiary.io/ You will write a small app that uses Coolpay API in Ruby. The app should be able do the following:

 1. Authenticate to Coolpay API
 2. Add recipients
 3. Send them money
 4. Check whether a payment was successful
 
```ruby
# Authenticating to Coolpay API...
CoolPay.login(username: "username", api_key: "app_key")
# Adding recipients...
CoolPay.add_recipient("User One")
# Send them money...
CoolPay.make_payment("10.5",recipient.id)
# Check whether a payment was successful...
payment.status=#{payment.status}
```