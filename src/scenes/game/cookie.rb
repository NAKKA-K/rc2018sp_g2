class Cookie < Item
    @@status = :cookie
    def status
        @@status
    end
    def update
        #@y += @dy
    end
end