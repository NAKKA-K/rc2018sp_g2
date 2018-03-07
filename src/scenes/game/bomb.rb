class Bomb < Item
    @@status = :bomb
    def status
        @@status
    end
    def update
        #@y += @dy
    end
end