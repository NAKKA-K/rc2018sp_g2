require_relative 'sensor'

class ButtonSensor < Sensor
    attr_reader :key_process

    def initialize(port: 0, pin: 0)
        super
        @key_process = 0
    end

    def update
        @raw_value = Sensor.board.digital_read(@pin)
        if on?
            @key_process += 1
        else
            @key_process = 0
        end
    end

    # 押した瞬間だけ判定する
    def down?
        @key_process == 1
    end

    # true,falseでのみ返す
    def on?
        if @raw_value == 1
            true
        else
            false
        end
    end

end