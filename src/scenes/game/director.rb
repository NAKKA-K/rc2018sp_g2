require_relative '../../sensors/button_sensor'
require_relative 'player'
require_relative 'item'
require_relative 'ruby'
require_relative 'python'
require_relative 'matz'
require 'smalrubot'

module Game

    class Director
        def initialize(board)
            @board = board
            #@ruby = ::Ruby.new(400,100,"images/ruby.png")
            #@python = ::Python.new(600,100,"images/python.png")
            @items = [::Ruby.new(400,100,"images/ruby.png"),::Python.new(400,100,"images/ruby.png")]
            @bg = Image.load("images/background.jpg")
            @frm = 1
            @dx = 0
            @button_sensor = ButtonSensor.new(pin: 2)
            #@button_right = ButtonSensor.new(pin: 6)
            #@button_left = ButtonSensor.new(pin: 8)
            @matz = Matz.new()
        end

        def play
            draw
            update
            @button_sensor.update
            #@button_right.update
            #@button_left.update
            @items[0].update
            @items[1].update
            @matz.draw
        end

        private

        def update
=begin
            @dx = 10 if @frm == 30 # @dxにセンサー等の値を入れる
            @frm += 1
            @frm = 0 if @frm > 30
=end
            #@python.update
            #@ruby.update
            
            if @button_sensor.down?
                SceneMgr.move_to(:result)
            end
=begin
            if @button_right.down?
                #@matz.receive_present(@ruby.status)
            end

            if @button_left.down?
                #@matz.receive_present(@python.status)
            end
=end
        end

        def draw
            Window.draw(0, 0, @bg)
            #@ruby.draw
            #@python.draw
            @items[0].draw
            @items[1].draw
        end
    end
end
