require_relative '../../sensors/button_sensor'
module Result
    
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