describe('Number', function()
    it('is addable', function()
        assert(1 + 1 == 2)
    end)

    it('knows equality for big numbers', function()
        assert(100^100 == 10^200)
    end)

    it('sadly is implemented as a double float', function()
        assert(tostring(50^50) == "8.8817841970013e+84")
    end)

    it('sadly is addable to strings', function()
        assert(1 + '1' == 2)
    end)
end)


describe('String', function()
    it('sadly uses the .. operator for concatenation', function()
        assert('a'..'b' == 'ab')
    end)

    it('sadly uses the # operator for length', function()
        assert(#'abc' == 3)
    end)
end)

