require_relative '../../sensors/button_sensor'

module Title
    class Director
        def initialize()
            @font = Font.new(32, 'MS Pゴシック')
            @button_sensor = ButtonSensor.instance
        end

        def play
            draw
            @button_sensor.update(ButtonSensor::LEFT_PIN)
            @button_sensor.update(ButtonSensor::RIGHT_PIN)
            update
        end

        private

        def update
            if $DEBUG && (@button_sensor.down?(ButtonSensor::LEFT_PIN) || 
                          @button_sensor.down?(ButtonSensor::RIGHT_PIN))
                SceneMgr.move_to(:game)
            end
        end

        def draw
            Window.draw_font(250, 280, "タイトル画面", @font)
        end
    end
end