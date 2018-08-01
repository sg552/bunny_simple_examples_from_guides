# encoding: utf-8
require 'rubygems'
require 'bunny'

STDOUT.sync = true

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue("another_good_news", :auto_delete => true)


# 这个方法就是订阅方法了。跟websocket 一样。有消息进来就触发里面的代码。
queue.subscribe do |delivery_info, metadata, payload|
  puts "== delivery_info: #{delivery_info.inspect}"
  puts "== metadata: #{metadata.inspect}"
  puts "== Received #{payload.inspect}"
end

puts "== queue: #{queue.inspect}"

# 在这里, 通过exchange, 发布一条消息, 只有订阅了 routing_key的人才能收到。
ex = channel.default_exchange
ex.publish("hihihi, I send, and you receive this message", :routing_key => queue.name)

sleep 1

connection.close
