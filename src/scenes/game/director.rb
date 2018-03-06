require_relative 'player'
require 'smalrubot'

module Game

    class Director
        def initialize(board)
            @board = board
            @player = Player.new
            @frm = 1
            @dx = 0
        end

        def play
            draw
            update
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

            if @board.digital_read(2) != 0
                SceneMgr.move_to(:result)
            end
        end

        def draw
            @player.draw
        end
    end

end

