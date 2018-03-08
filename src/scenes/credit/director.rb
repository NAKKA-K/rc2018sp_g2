require_relative '../../sensors/button_sensor'
require_relative '../../sensors/leng_sensor'
module Credit
    
    class Director
        def initialize()
            @font = Font.new(40, 'MS Pゴシック')
            @button_sensor = ButtonSensor.instance
            @leng_sensor = LengSensor.instance
            @image = Image.load("images/credit.jpg")
        end

        def play
            draw
            if $DEBUG
                @button_sensor.update(ButtonSensor::LEFT_PIN); @button_sensor.update(ButtonSensor::RIGHT_PIN)
            end
            @leng_sensor.update(LengSensor::LEFT_PIN); @leng_sensor.update(LengSensor::RIGHT_PIN)
            update
        end

        private

        def update
            if $DEBUG && (@button_sensor.down?(ButtonSensor::LEFT_PIN) || 
                          @button_sensor.down?(ButtonSensor::RIGHT_PIN))
                SceneMgr.move_to(:title)
            elsif @leng_sensor.down?(LengSensor::RIGHT_PIN) ||
                  @leng_sensor.down?(LengSensor::LEFT_PIN)
                SceneMgr.move_to(:title)
            end
        end

        def draw
            Window.draw(0, 0, @image)
            Window.draw_font(320, 80, "クレジット", @font)
            Window.draw_font(50, 200, "  プログラマ  　 中村翔    越智亮太", @font)
            Window.draw_font(50, 300, "ハードウェア　 武本和久 　柳原直樹", @font)
        end
    end

end