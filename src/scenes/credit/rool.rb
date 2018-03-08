class Rool
  
    def initialize
	
	@font = Font.new(40, 'MS Pゴシック')
        @button_sensor = ButtonSensor.instance
        @leng_sensor = LengSensor.instance
	@image = Image.load("#{$ROOT_PATH}/images/credit.jpg")
        @y = 0
        @dy = 3
    end

    def draw
	Window.draw(0, 0, @image)
        Window.draw_font(320, 80, "クレジット", @font)
	Window.draw_font(50, 200, "  プログラマ  　 中村翔    越智亮太", @font)
	Window.draw_font(50, 300, "ハードウェア　 武本和久 　柳原直樹", @font)
    end
end

