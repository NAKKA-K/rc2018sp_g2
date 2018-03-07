class Python < Item
    @@status = :python
    def status
        @@status
    end
    def update
        @y += @dy
    end
end