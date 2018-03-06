module Result
    
    class Director
        def initialize(board)
            @font = Font.new(32, 'MS Pゴシック')
            @board = board
        end

        def play
            draw
            update
        end

        private

        def update
            if @board.digital_read(2) != 0
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