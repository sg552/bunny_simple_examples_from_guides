require 'rubygems'
require 'bunny'

STDOUT.sync = true

connection = Bunny.new
connection.start

channel = connection.create_channel

exchange = channel.topic "weather", :auto_delete => true

channel.queue("", :exclusive => true).bind(exchange, routing_key: 'beijing').subscribe do |delivery_info, metadata, payload |
  puts "An update weather: #{payload}, routing_key: #{delivery_info.routing_key}"
end
channel.queue("shi_jia_zhuang").bind(exchange, routing_key: 'hebei').subscribe do |delivery_info, metadata, payload |
  puts "An update weather: #{payload}, routing_key: #{delivery_info.routing_key}"
end
channel.queue("liaoning").bind(exchange, routing_key: 'liaoning').subscribe do |delivery_info, metadata, payload |
  puts "An update weather: #{payload}, routing_key: #{delivery_info.routing_key}"
end

exchange.publish "38 c", routing_key: 'hebei'
exchange.publish "36 c", routing_key: 'liaoning'
#exchange.publish "34 c", routing_key: 'lalala'

connection.close
