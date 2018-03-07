require_relative '../../sensors/button_sensor'

module Title
    class Director
        def initialize(board)
            @font = Font.new(64, 'MS Pゴシック')
            @board = board
            @button_right = ButtonSensor.new(pin: 6)
            @button_left = ButtonSensor.new(pin: 8)
	    @image = Image.load('images/title.png')
	    @backimg = Image.load('images/backimg.bmp')
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
	    Window.draw_scale(0, 0, @backimg, 2.5, 2.5,)
            Window.draw_font(250, 100, "ときめきMatz", @font)
	    Window.draw_scale(-100, 0, @image, 0.6, 0.6,)
        end
    end
end
