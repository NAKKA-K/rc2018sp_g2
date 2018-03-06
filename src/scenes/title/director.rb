require_relative '../../sensors/button_sensor'

module Title
    
    class Director
        def initialize(board)
            @font = Font.new(32, 'MS Pゴシック')
            @board = board
            @button_sensor = ButtonSensor.new(pin: 2)
        end

        def play
            draw
            update
            @button_sensor.update
        end

        private

        def update
            if Input.key_push?(K_RETURN)
                SceneMgr.move_to(:game)
            elsif @button_sensor.down?
                SceneMgr.move_to(:game)
            end
        end

        def draw
            Window.draw_font(250, 280, "タイトル画面", @font)

            if $DEBUG
            end
        end
    end

end