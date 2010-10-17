function describe(name, callable)
    print()
    print(name)
    callable()
end


function it(name, callable)
    print("  - "..name)
    callable()
end


function before(callable)
    callable()
end


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


describe('Function', function()
    it('is defineable inline', function()
        local f = function() return 5 end
        assert(f() == 5)
    end)

    it('sadly defaults arguments to nil', function()
        function f(an_arg)
            return an_arg
        end
        assert(f() == nil)
    end)
end)


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


describe('A class', function()
    before(function()
        Dog = {
            new = function(self)
                dog = {}
                setmetatable(dog, self)
                self.__index = self
                return dog
            end,
            bark = function(self)
                return 'arf!'
            end
        }
    end)

    it('has class methods', function()
        assert(Dog.bark() == 'arf!')
    end)

    it('has instance methods', function()
        assert(Dog:new():bark() == 'arf!')
    end)

    it('has instances that equal themselves', function()
        dog = Dog:new()
        assert(dog == dog)
    end)

    it('has independent instance objects', function()
        assert(Dog:new() ~= Dog:new())
    end)
end)

