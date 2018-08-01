require 'rubygems'
require 'bunny'

STDOUT.sync= true

conn = Bunny.new
conn.start

ch = conn.create_channel

# 先使用这个 channel
x = ch.fanout 'nba.scores'

# 再使用这几个queue
# 每个queue, 都会绑定这个 exchange (nba.scores)
ch.queue("joe", :auto_delete => true).bind(x).subscribe do |delivery_info, metadata, payload|
  puts "#{payload} => joe"
end

ch.queue("aaron", :auto_delete => true).bind(x).subscribe do |delivery_info, metadata, payload|
  puts "#{payload} => aaron "
end
ch.queue("jim", :auto_delete => true).bind(x).subscribe do |delivery_info, metadata, payload|
  puts "#{payload} => jim "
end

x.publish "lala1, kaka2"
x.publish "lueluelue"

conn.close
