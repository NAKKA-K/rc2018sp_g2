class ButtonSensor < Sensor
    attr_reader :raw_value

    def initialize(port: 0, pin: 0)
        super
        @key_process = 0
    end

    def update
        if !!(@raw_value = Sensor.board.digital_read(@pin))
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
        !!@raw_value
    end

end