require_relative '../../sensors/button_sensor'
module Result
    
    class Director
        def initialize(board)
            @font = Font.new(32, 'MS Pゴシック')
            @board = board
            @button_right = ButtonSensor.new(pin: 6)
            @button_left = ButtonSensor.new(pin: 8)
        end

        def play
            draw
            update
            @button_right.update
            @button_left.update
        end

        private

        def update
            if $DEBUG && (@button_right.down? || @button_left.down?)
                SceneMgr.move_to(:credit)
            end
        end

        def draw
            Window.draw_font(250, 280, "結果画面", @font)

            if $DEBUG
                p @board.digital_read(2)
            end
        end
    end

end