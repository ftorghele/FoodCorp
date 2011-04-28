require 'cramp'
require 'thin'

Cramp::Websocket.backend = :thin

class ChatAction < Cramp::Websocket
  on_data :received_data

  def received_data(data)
    puts "#{data}"
    send_hello_world
  end
  
  def send_hello_world
      render "Hello FoodCorp User! <message from server>"
  end
end

Thin::Logging.trace = true
