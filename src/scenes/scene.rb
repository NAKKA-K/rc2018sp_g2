class Scene
    def initialize(board)
        @font = Font.new(32, 'MS Pゴシック')
        @board = nil
    end

    def play
        raise NotImplementedError
    end

    private
    
    def update
        raise NotImplementedError
    end

    def draw
        raise NotImplementedError
    end
end