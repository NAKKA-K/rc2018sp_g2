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
            if @button_sensor.down?
                SceneMgr.move_to(:game)
            end
        end

        def draw
            Window.draw_font(250, 280, "タイトル画面", @font)

            if $DEBUG
                p @button_sensor.raw_value
            end
        end
    end
end