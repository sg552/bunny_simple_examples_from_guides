require 'bunny'

connection = Bunny.new
connection.start

ch = connection.create_channel

queue = ch.queue('good_news')

queue.publish "hello~ I have a good news!"


delivery_info, metadata, payload = queue.pop

puts "== delivery_info: #{delivery_info.inspect}"
puts "== metadata: #{metadata.inspect}"
puts "== payload: #{payload.inspect}"

connection.stop
