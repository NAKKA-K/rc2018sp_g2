class Ruby < Item

    @@status = :ruby
    def status
        @@status
    end
    def update
        @y += @dy
    end
end