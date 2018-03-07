class Item
    attr_reader :y
    attr_reader :height
    @status = nil
    def initialize(x = 0,y = 300,image)
        @image = Image.load(image)
        @height = @image.height
        @x = x
        @y = y
        @dy = 3
    end

    def draw
        Window.draw(@x,@y,@image)
    end


    def self.status
        @status
    end

    def update
        @y += @dy
    end
end