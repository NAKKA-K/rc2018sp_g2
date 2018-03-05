module Title
    
    class Director
        def initialize(board)
            @font = Font.new(32, 'MS Pゴシック')
        end

        def play
            draw
            update
        end

        private

        def update
            if Input.key_push?(K_RETURN)
                Scene.move_to(:game)
            end
        end

        def draw
            Window.draw_font(250, 280, "タイトル画面", @font)
        end
    end

end