require_relative '../../sensors/button_sensor'
require_relative 'player'
require_relative 'item'
require_relative 'ruby'
require_relative 'python'
require_relative 'castle'
require_relative 'bomb'
require_relative 'cookie'
require_relative 'matz'
require 'smalrubot'

def update_time(time_frame)
    time_frame += 1
end

def update_image(x,image_random_seed)
    case image_random_seed
    when 0 then
        ::Ruby.new(x,100,"images/ruby.png")
    when 1 then
        ::Python.new(x,100,"images/python.png")
    when 2 then
        ::Castle.new(x,100,"images/castle.jpg")
    when 3 then
        ::Cookie.new(x,100,"images/cookie.png")
    when 4 then
        ::Bomb.new(x,100,"images/bomb.png")
    end
end

module Game
    class Director
        def initialize()
            @button_sensor = ButtonSensor.instance()
            @ruby = ::Ruby.new(400,100,"images/ruby.png")
            @python = ::Python.new(500,100,"images/python.png")
            @bg = Image.load("images/background.jpg")
            @frm = 1
            @dx = 0
            @time_frame = 0
            @item_num = 5
            @image_random_seed = Random.new
            @matz = Matz.new()
        end

        def play
            draw
            @button_sensor.update(ButtonSensor::LEFT_PIN)
            @button_sensor.update(ButtonSensor::RIGHT_PIN)
            @item_right.update
            @item_left.update
            update
        end

        private

        def update
            @dx = 10 if @frm == 30 # @dxにセンサー等の値を入れる
            @frm += 1
            @frm = 0 if @frm > 30
            @time_frame = update_time(@time_frame)
            if(@time_frame % 90 == 0)
                @item_left = update_image(400,@image_random_seed.rand(@item_num))
                @item_right = update_image(600,@image_random_seed.rand(@item_num))
            end

            if @button_sensor.down?
                SceneMgr.move_to(:result)
            end
            
            if $DEBUG && (@button_sensor.down?(ButtonSensor::LEFT_PIN) || 
                          @button_sensor.down?(ButtonSensor::RIGHT_PIN))
                #SceneMgr.move_to(:result)
            end

            if $DEBUG && @button_sensor.down?(ButtonSensor::RIGHT_PIN)
                @matz.receive_present(@item_right.status)
            end

            if $DEBUG && @button_sensor.down?(ButtonSensor::LEFT_PIN)
                @matz.receive_present(@item_left.status)
            end
        end

        def draw
            Window.draw(0, 0, @bg)
            @item_right.draw
            @item_left.draw
            @matz.draw
        end
    end
end