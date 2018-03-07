require_relative '../../config'
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
        ::Ruby.new(x,100,"#{$ROOT_PATH}/images/ruby.png")
    when 1 then
        ::Python.new(x,100,"#{$ROOT_PATH}/images/python.png")
    when 2 then
        ::Castle.new(x,100,"#{$ROOT_PATH}/images/castle.jpg")
    when 3 then
        ::Cookie.new(x,100,"#{$ROOT_PATH}/images/cookie.png")
    when 4 then
        ::Bomb.new(x,100,"#{$ROOT_PATH}/images/bomb.png")
    end
end

module Game
    class Director
        def initialize()
            @button_sensor = ButtonSensor.instance()
            @bg = Image.load("#{$ROOT_PATH}/background.jpg")
            @item_right = ::Ruby.new(299,100,"#{$ROOT_PATH}/ruby.png")	
            @item_left = ::Python.new(401,100,"#{$ROOT_PATH}/python.png")
            @lane_right = Image.new(100,600,[200,252,190,193]).box_fill(0, 450, 100, 600,[150,249,130,137])
            @lane_center =  Image.new(2,600,[255,255,255])
            @lane_left = Image.new(100,600,[200,252,190,193]).box_fill(0, 450, 100, 600,[150,249,130,137])
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
                @item_left = update_image(299,@image_random_seed.rand(@item_num))
                @item_right = update_image(401,@image_random_seed.rand(@item_num))
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
            Window.draw(299, 0, @lane_left)
            Window.draw(399, 0, @lane_center)
            Window.draw(401, 0, @lane_right)
            @item_right.draw
            @item_left.draw
            #@matz.draw
        end
    end
end
