class Item
    def initialize(x = 300,y = 300)
        @image = Image.load('images/ruby.png')
        @image.set_color_key(C_BLACK)
        @x = x
        @y = y
    end
    
    def draw
        Window.drow(@x,@y,@image)
    end
end