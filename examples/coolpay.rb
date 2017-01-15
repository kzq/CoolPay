  load 'lib/cool_pay.rb'

puts "===========Authenticating to Coolpay API..."

CoolPay.login(username: "username", api_key: "api_key")

puts "CoolPay.id = #{CoolPay.username}" 
puts "CoolPay.api_key = #{CoolPay.api_key}"
puts "CoolPay.token = #{CoolPay.token}" 

puts "===========Adding recipients..."

ben=CoolPay.add_recipient("Ben Barker")
puts "ben.id=#{ben.id}"
puts "ben.name=#{ben.name}"

selina=CoolPay.add_recipient("Selina Linton")
puts "selina.id=#{selina.id}"
puts "selina.name=#{selina.name}"


puts "===========Send them money..."

payment = CoolPay.make_payment("10.5",ben.id)

puts "payment.id=#{payment.id}"
puts "payment.amount=#{payment.amount}"
puts "payment.currency=#{payment.currency}"
puts "payment.recipient_id=#{payment.recipient_id}"
puts "payment.status=#{payment.status}"

puts "===========Check whether a payment was successful..."

puts "payment.status=#{payment.status}"
