require_relative '../../sensors/button_sensor'

module Title
    class Director
        def initialize(board)
            @font = Font.new(32, 'MS Pゴシック')
            @board = board
            @button_right = ButtonSensor.new(pin: 6)
            @button_left = ButtonSensor.new(pin: 8)
        end

        def play
            draw
            @button_right.update
            @button_left.update
            if $DEBUG
                p @button_left.key_process
            end
            update
        end

        private

        def update
            if $DEBUG && (@button_right.down? || @button_left.down?)
                SceneMgr.move_to(:game)
            end
        end

        def draw
            Window.draw_font(250, 280, "タイトル画面", @font)
        end
    end
end