class Ruby < Item
    @@status = "Ruby"
    def status
        @@status
    end
    def update
        @y += @dy
    end
end