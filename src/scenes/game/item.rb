class Item
    def initialize(x = 0,y = 0)
        @image_ruby = Image.load('images/ruby.png')
        @image_ruby.set_color_key(C_WHITE)
        @image_python = Image.load('images/python.png')
        @image_python.set_color_key(C_WHITE)

        @x = x
        @y = y
    end
    
    def draw
        Window.draw(250,300,@image_ruby)
        Window.draw(550,300,@image_python)
    end
end