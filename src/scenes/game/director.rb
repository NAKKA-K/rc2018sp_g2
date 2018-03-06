require_relative '../../sensors/button_sensor'
require_relative 'player'
require_relative 'item'
require 'smalrubot'

module Game

    class Director
        def initialize(board)
            @board = board
            @player = Player.new
            @item = Item.new
            @frm = 1
            @dx = 0
            @button_sensor = ButtonSensor.new(pin: 2)
        end

        def play
            draw
            update
            @button_sensor.update
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

            if @button_sensor.down?
                SceneMgr.move_to(:result)
            end
        end

        def draw
            @player.draw
            @item.draw
        end
    end

end

