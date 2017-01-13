#TO DO
# status codes, erros, tests, timeout

load 'lib/cool_pay.rb'

puts "===========Authenticating to Coolpay API..."

CoolPay.login(username: "kamran", api_key: "C812E5BEC4E315C9")

puts "CoolPay.id = #{CoolPay.username}" 
puts "CoolPay.api_key = #{CoolPay.api_key}"
puts "CoolPay.token = #{CoolPay.token}" 

#{"token":"46338fc1-8136-4f7d-8a75-3312d4634cbc"}

puts "===========Adding recipients..."

ben=CoolPay.add_recipient("Ben Barker")
puts "ben.id=#{ben.id}"
puts "ben.name=#{ben.name}"

selina=CoolPay.add_recipient("Selina Linton")
puts "selina.id=#{selina.id}"
puts "selina.name=#{selina.name}"


puts "===========Send them money..."

payment = CoolPay.make_payment("10.5",ben.id)
#payment = CoolPay.make_payment(10.5,"51aada7c-24d7-4636-971f-f47e2afd714f")
puts "payment.id=#{payment.id}"
puts "payment.amount=#{payment.amount}"
puts "payment.currency=#{payment.currency}"
puts "payment.recipient_id=#{payment.recipient_id}"
puts "payment.status=#{payment.status}"

puts "===========Check whether a payment was successful..."

puts "payment.status=#{payment.status}"
