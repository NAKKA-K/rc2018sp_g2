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
            @ruby = ::Ruby.new(400,100,"images/ruby.png")
            @python = ::Python.new(500,100,"images/python.png")
            @bg = Image.load("images/background.jpg")
            @frm = 1
            @dx = 0
            @button_sensor = ButtonSensor.new(pin: 2)
            @button_right = ButtonSensor.new(pin: 6)
            @button_left = ButtonSensor.new(pin: 8)
            @matz = Matz.new()
        end

        def play
            draw
            update
            @button_sensor.update
            @button_right.update
            @button_left.update
        end

        private

        def update
            @dx = 10 if @frm == 30 # @dxにセンサー等の値を入れる
            @frm += 1
            @frm = 0 if @frm > 30
            
            @python.update
            @ruby.update
            
            if $DEBUG && @button_sensor.down?
                #SceneMgr.move_to(:result)
            end

            if @button_right.down?
                @matz.receive_present(@ruby.status)
            end

            if @button_left.down?
                @matz.receive_present(@python.status)
            end
        end

        def draw
            Window.draw(0, 0, @bg)
            @matz.draw
            @ruby.draw
            @python.draw
        end
    end
end
