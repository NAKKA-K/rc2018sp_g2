require 'smalrubot'


class Sensor
    @@board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)

    attr_reader :raw_value :board

    def initialize(port: 0, pin: 0)
        @port = port
        @pin = pin
        @raw_value = 0
    end

    # raw_valueなど、センサーからの値更新
    def update
        raise NotImplementedError
    end
    
    # true,falseでのみ返す
    def on?
        raise NotImplementedError
    end
end