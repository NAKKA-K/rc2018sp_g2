class Item
    attr_reader :y
    def initialize(x = 0,y = 300,image)
        @image = Image.load(image)
        @x = x
        @y = y
        @dy = 1
    end

    def draw
        Window.draw(@x,@y,@image)
    end
end