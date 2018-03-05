require 'smalrubot'


loop do
    p board.degital_read(2)
end

class Sensor
    board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)

    def initialize(port: 0, pin: 0)
        @port = port
        @pin = pin
        @raw_value = 0
    end

    def update
        raise NotImplementedError
    end

    def raw_value=()
        raise NotImplementedError
    end

    # true,falseでのみ返す
    def digital_on?
        raise NotImplementedError
    end
end