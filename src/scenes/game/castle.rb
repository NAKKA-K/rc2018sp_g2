class Castle < Item
    @@status = :castle
    def status
        @@status
    end
    def update
        #@y += @dy
    end
end