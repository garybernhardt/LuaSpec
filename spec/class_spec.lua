describe('A class', function()
    before(function()
        Dog = {}

        function Dog.new(class)
            dog = {}
            setmetatable(dog, class)
            class.__index = class
            return dog
        end

        function Dog:bark()
            return 'arf!'
        end
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

