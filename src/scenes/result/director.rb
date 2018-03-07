require_relative '../../sensors/button_sensor'
require_relative '../../sensors/leng_sensor'
require_relative '../game/matz'

module Result
    
    class Director
        def initialize()
            @font = Font.new(32, 'MS Pゴシック')
            @button_sensor = ButtonSensor.instance
            @leng_sensor = LengSensor.instance
            @big_matz = Image.load("#{$ROOT_PATH}/images/big_matz.jpeg")
        end

        def play
            draw
            if $DEBUG
                @button_sensor.update(ButtonSensor::LEFT_PIN)
                @button_sensor.update(ButtonSensor::RIGHT_PIN)
            end
            @leng_sensor.update(LengSensor::LEFT_PIN)
            @leng_sensor.update(LengSensor::RIGHT_PIN)
            update
        end

        private

        def update
            if $DEBUG && (@button_sensor.down?(ButtonSensor::LEFT_PIN) || 
                          @button_sensor.down?(ButtonSensor::RIGHT_PIN))
                SceneMgr.move_to(:credit)
            elsif @leng_sensor.down?(LengSensor::RIGHT_PIN) ||
                  @leng_sensor.down?(LengSensor::LEFT_PIN)
                SceneMgr.move_to(:credit)
            end
        end

        def draw
            Window.draw_font(400, 100, "結果画面", @font)
            Window.draw(25, 100, @big_matz)
            Window.draw_font(600, 300, "#{Matz.favorability_status}", @font)
            Window.draw_font(600, 500, "#{Matz.favorability_rate}", @font)
        end
    end

end