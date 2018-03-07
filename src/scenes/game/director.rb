require_relative '../../config'
require_relative '../../sensors/button_sensor'
require_relative '../../sensors/leng_sensor'
require_relative 'player'
require_relative 'item'
require_relative 'ruby'
require_relative 'python'
require_relative 'castle'
require_relative 'bomb'
require_relative 'cookie'
require_relative 'matz'
require_relative 'game_timer'
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
            @button_sensor = ButtonSensor.instance
            @leng_sensor = LengSensor.instance
            @bg = Image.load("#{$ROOT_PATH}/images/background.jpg")
            @item_right = ::Ruby.new(400,100,"#{$ROOT_PATH}/images/ruby.png")
            @item_left = ::Python.new(600,100,"#{$ROOT_PATH}/images/python.png")
            @frm = 1
            @dx = 0
            @time_frame = 0
            @item_num = 5
            @image_random_seed = Random.new
            @matz = Matz.new()
            @timer = GameTimer.new()
            @font = Font.new(32, 'MS Pゴシック')
        end

        def play
            if $DEBUG
                @timer.start(how_many: 30)
            else
                @timer.start(how_many: 60)
            end

            draw
            @button_sensor.update(ButtonSensor::LEFT_PIN)
            @button_sensor.update(ButtonSensor::RIGHT_PIN)
            @leng_sensor.update(LengSensor::LEFT_PIN)
            @leng_sensor.update(LengSensor::RIGHT_PIN)
            @item_right.update
            @item_left.update
            update
            @timer.update
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

            if $DEBUG && @timer.stop?
                SceneMgr.move_to(:result)
                @timer.reset
            end

            if $DEBUG && @button_sensor.down?(ButtonSensor::RIGHT_PIN)
                @matz.receive_present(@item_right.status)
            elsif @leng_sensor.down?(LengSensor::RIGHT_PIN)
                @matz.receive_present(@item_right.status)
            end

            if $DEBUG && @leng_sensor.down?(ButtonSensor::LEFT_PIN)
                @matz.receive_present(@item_left.status)
            elsif @leng_sensor.down?(LengSensor::LEFT_PIN)
                @matz.receive_present(@item_left.status)
            end
        end

        def draw
            Window.draw(0, 0, @bg)
            @item_right.draw
            @item_left.draw
            @matz.draw
            Window.draw_font(630, 30, "Time: #{@timer.remaining_time.round(2)}", @font, color: [0,0,0])
        end
    end
end
