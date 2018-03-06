require_relative '../../sensors/button_sensor'
require_relative 'player'
require_relative 'item'
require_relative 'ruby'
require_relative 'matz'
require 'smalrubot'

module Game

    class Director
        def initialize(board)
            @board = board
            @player = Player.new
            @ruby = ::Ruby.new(100,100,"images/python.png")
            @bg = Image.load("images/background.jpg")
            @frm = 1
            @dx = 0
            @button_sensor = ButtonSensor.new(pin: 2)
            @matz = Matz.new()
        end
        def play
            draw
            update
            @button_sensor.update
            @matz.draw
        end

        private

        def update
            @dx = 10 if @frm == 30 # @dxにセンサー等の値を入れる
            @frm += 1
            @frm = 0 if @frm > 30

            @player.x += @dx if Input.key_down?(K_RIGHT)
            @player.x -= @dx if Input.key_down?(K_LEFT)
            @player.y -= @dx if Input.key_down?(K_UP)
            @player.y += @dx if Input.key_down?(K_DOWN)

            @ruby.update
            if @button_sensor.down?
                SceneMgr.move_to(:result)
            end
        end

        def draw
            Window.draw(0, 0, @bg)
            @player.draw
            @ruby.draw
        end
    end
end
