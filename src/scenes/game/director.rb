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
    puts image_random_seed
    case image_random_seed
    when (0..30) then
        ::Ruby.new(x,0,"#{$ROOT_PATH}/images/ruby_notes.png")
    when (30..60) then
        ::Castle.new(x,0,"#{$ROOT_PATH}/images/castle_notes.jpg")
    when (60..80) then
        ::Python.new(x,0,"#{$ROOT_PATH}/images/python_notes.png")
    when (80..90) then
        ::Bomb.new(x,0,"#{$ROOT_PATH}/images/bomb_notes.png")
    when (90..100) then
        ::Cookie.new(x,0,"#{$ROOT_PATH}/images/cookie_notes.png")
    end
end

def check_add_point(item_center,height)
    if 450- (height / 2) <= item_center && item_center <= 600 - (height / 2)
        true
    else
        false
    end
end

module Game
    class Director
        def initialize()
            @button_sensor = ButtonSensor.instance
            @leng_sensor = LengSensor.instance
            @bg = Image.load("#{$ROOT_PATH}/images/background.jpg")
            @item_right = ::Ruby.new(299,0,"#{$ROOT_PATH}/images/ruby_notes.png")	
            @item_left = ::Python.new(401,0,"#{$ROOT_PATH}/images/python_notes.png")
            @lane_right = Image.new(100,600,[200,252,190,193]).box_fill(0, 450, 100, 600,[150,249,130,137])
            @lane_center =  Image.new(2,600,[255,255,255])
            @lane_left = Image.new(100,600,[200,252,190,193]).box_fill(0, 450, 100, 600,[150,249,130,137])
            @frm = 1
            @dx = 0
            @dy = 1
            @time_frame = 0
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
            if $DEBUG
                @button_sensor.update(ButtonSensor::LEFT_PIN)
                @button_sensor.update(ButtonSensor::RIGHT_PIN)
            end
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
            if(@time_frame % 300 == 0)
                @item_left = update_image(299,@image_random_seed.rand(100))
                @item_right = update_image(401,@image_random_seed.rand(100))
            end

            if $DEBUG && @timer.stop?
                SceneMgr.move_to(:result)
                @timer.reset
            end

            if $DEBUG && @button_sensor.down?(ButtonSensor::RIGHT_PIN)
                if check_add_point(@item_right.y,@item_right.height)
                    @matz.receive_present(@item_right.class.status)
                end
            elsif @leng_sensor.down?(LengSensor::RIGHT_PIN)
                if check_add_point(@item_right.y,@item_right.height)
                    @matz.receive_present(@item_right.class.status)
                end
            end

            if $DEBUG && @button_sensor.down?(ButtonSensor::LEFT_PIN)
                if check_add_point(@item_left.y,@item_left.height)
                    @matz.receive_present(@item_left.class.status)
                end
            elsif @leng_sensor.down?(LengSensor::LEFT_PIN)
                if check_add_point(@item_left.y,@item_left.height)
                    @matz.receive_present(@item_left.class.status)
                end
            end
        end

        def draw
            Window.draw(0, 0, @bg)
            Window.draw(299, 0, @lane_left)
            Window.draw(399, 0, @lane_center)
            Window.draw(401, 0, @lane_right)
            @item_right.draw
            @item_left.draw
            @matz.draw
            Window.draw_font(630, 30, "Time: #{@timer.remaining_time.round(2)}", @font, color: [0,0,0])
        end
    end
end