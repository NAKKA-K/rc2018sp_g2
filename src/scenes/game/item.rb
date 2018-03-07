class Item
    attr_reader :y
    attr_reader :height
    def initialize(x = 0,y = 300,image)
        @image = Image.load(image)
        @height = @image.height
        @x = x
        @y = y
        @dy = 2
    end

    def draw
        Window.draw(@x,@y,@image)
    end
end