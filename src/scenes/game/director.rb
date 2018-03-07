require_relative '../../sensors/button_sensor'
require_relative 'player'
require_relative 'item'
require_relative 'ruby'
require_relative 'python'
require_relative 'matz'
require 'smalrubot'

def time_update(time_frame)
    time_frame += 1
end

def update_image(x,image_random_seed)
    puts image_random_seed
    puts x
    case image_random_seed
    when 0 then
        ::Ruby.new(x,100,"images/ruby.png")
    when 1 then
        ::Python.new(x,100,"images/python.png")
    end
end

module Game
    class Director
        def initialize(board)
            @board = board
            @item_right = ::Ruby.new(400,100,"images/ruby.png")
            @item_left = ::Python.new(600,100,"images/python.png")
            @bg = Image.load("images/background.jpg")
            @frm = 1
            @dx = 0
            @time_frame = 0
            @image_random_seed = Random.new
            @button_sensor = ButtonSensor.new(pin: 2)
            #@button_right = ButtonSensor.new(pin: 6)
            #@button_left = ButtonSensor.new(pin: 8)
            @matz = Matz.new()
        end

        def play
            draw
            update
            @button_sensor.update
            #@button_right.update
            #@button_left.update
            @item_right.update
            @item_left.update
            @matz.draw
        end

        private

        def update
            @dx = 10 if @frm == 30 # @dxにセンサー等の値を入れる
            @frm += 1
            @frm = 0 if @frm > 30

            update_image(@time_frame)
            if(@time_frame % 180 == 0)
                @frm_second = 0
                @item_left = update_image(400,@image_random_seed.rand(@item_num))
                @item_right = update_image(600,@image_random_seed.rand(@item_num))
            end

            if @button_sensor.down?
                SceneMgr.move_to(:result)
            end
=begin
            if @button_right.down?
                #@matz.receive_present(@ruby.status)
            end

            if @button_left.down?
                #@matz.receive_present(@python.status)
            end
=end
        end

        def draw
            Window.draw(0, 0, @bg)
            @item_right.draw
            @item_left.draw
        end
    end
end
