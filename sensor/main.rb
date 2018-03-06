require 'dxruby'
require 'smalrubot'

Window.caption = "RubyCamp Example"

Window.width   = 800
Window.height  = 600

board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)
font = Font.new(32)

count = 0
sensor = board.analog_read(0)

Window.loop do
  count += 1
  sensor = board.analog_read(0) if count % 60 == 0
  Window.draw_font(100, 100, sensor.to_s, font)
end
