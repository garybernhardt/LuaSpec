describe('pcall, the exception catcher', function()
    it('returns false when exceptions happen', function()
        f = function() foo() end
        local ok, err = pcall(f)
        assert(ok == false)
    end)

    it('returns true when no exception is raised', function()
        f = function() return 5 end
        local ok, err = pcall(f)
        assert(ok == true)
    end)

    it('returns the raised object', function()
        f = function() error({code=15}) end
        local ok, err = pcall(f)
        assert(err.code == 15)
    end)

    it("sadly the raised object isn't equal to the original", function()
        f = function() error(15) end
        local ok, err = pcall(f)
        assert(err ~= 15)
    end)
end)

