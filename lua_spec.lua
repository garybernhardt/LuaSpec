require 'spec_runner'


describe('Assignment', function()
    it('sadly throws away extra values', function()
        x, y = 1, 2, 3
        assert(x == 1 and y == 2)
    end)

    it('sadly fills in missing values with nils', function()
        x, y = 1
        assert(x == 1 and y == nil)
    end)

    it('sadly interpolates calls into the value list', function()
        local f = function() return 2, 3 end
        x, y, z = 1, f()
        assert(x == 1)
        assert(y == 2)
        assert(z == 3)
    end)

    it("sadly swallows extra values in parenthesized calls", function()
        local f = function() return 2, 3 end
        x, y, z = 1, (f())
        assert(x == 1)
        assert(y == 2)
        assert(z == nil)
    end)

    it('evaluates the values before assigning', function()
        a = {}
        i = 3
        i, a[i] = i + 1, 20
        assert(i == 4)
        assert(a[3] == 20)
        assert(a[4] == nil)
    end)
end)


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

    it('sadly returns variable results depending on context', function()
        function f()
            return 'first', 'second'
        end
        function g(x, y)
            return {x, y}
        end
        truncated = {f(), 'outside'}
        not_truncated = {f()}
        assert(truncated[1] == 'first' and truncated[2] == 'outside')
        assert(not_truncated[1] == 'first' and not_truncated[2] == 'second')
    end)
end)


describe('Function arguments', function()
    it('are passed by reference', function()
        function f(table)
            table.a = 2
        end
        local table = {a=1}
        f(table)
        assert(table.a == 2)
    end)

    it("are not mutable when they're primitive", function()
        function f(number, string)
            number = 2
            string = 'b'
        end
        local number = 1
        local string = 'a'
        f(number, string)
        assert(number == 1, string == 'a')
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


describe('A table', function()
    it('allows element access with brackets or dot', function()
        table = {a=1, b=2}
        assert(table['a'] == 1 and table.a == 1)
    end)

    it('is writeable', function()
        table = {}
        table['a'] = 1
        table.b = 2
        assert(table.a == 1 and table.b == 2)
    end)

    it('does not allow nil keys', function()
        table = {}
        assert_raises(function() table[nil] = 1 end)
    end)

    it('allows nil values', function()
        table = {a=nil}
        assert(table.a == nil)
    end)

    it('sadly returns nil by default', function()
        table = {}
        assert(table.a == nil)
    end)

    it('sadly does not equal an identical table', function()
        assert({a=1} ~= {a=1})
    end)

    it('sadly uses the # operator for length', function()
        assert(#{1, 2, 3} == 3)
    end)

    it('sadly has two syntaxes for separating elements', function()
        assert(#{1, 2; 3} == 3)
    end)

    it('interestingly has bracket syntax for non-identifier keys', function()
        inner_table = {'the inner table'}
        table = {[inner_table]=5}
        next_fn = pairs(table)
        key = next_fn(table)
        assert(key[1] == 'the inner table')
    end)
end)


describe('A table used as an array', function()
    it('has a size', function()
        assert(#{1, 2, 3} == 3)
    end)

    it('sadly begins indexing at 1', function()
        array = {'x'}
        assert(array[1] == 'x')
    end)

    it('contains elements in order', function()
        array = {10, 20, 30}
        assert(array[1] == 10 and array[2] == 20 and array[3] == 30)
    end)

    it('can contain duplicate elements', function()
        array = {10, 20, 10}
        assert(array[1] == array[3])
    end)

    xit('sadly considers any nil element as the end_ of the list', function()
        -- I can't find an example to make this pass, but the manual claims
        -- that it's true. The following fails:
        -- assert(#{1, 2, nil, 3} == 2)
    end)
end)


describe('If statement', function()
    it('requires a then', function()
        if true then
            x = 5
        end
        assert(x == 5)
    end)
end)


describe('While loop', function()
    it('requires a do', function()
        counter, sum = 0, 0
        while counter < 3 do
            counter, sum = counter + 1, sum + 10
        end
        assert(sum == 30)
    end)
end)


describe('Repeat loop', function()
    -- Vim bug: indentation fails if there's an "until" word in a string
    it('has an _until_ clause', function()
        counter, sum = 0, 0
        repeat
            counter, sum = counter + 1, sum + 10
        until counter > 3
        assert(sum == 40)
    end)
end)


describe('Break', function()
    it('exits loops', function()
        x = 0
        while true do
            x = x + 1
            break
        end
        assert(x == 1)
    end)

    xit('sadly must be the last statement in a block')
end)


describe('A numeric for loop', function()
    it('sadly exists', function()
        numbers = {}
        for v = 1, 3, 2 do
            numbers[#numbers + 1] = v
        end
        assert(numbers[1] == 1 and numbers[2] == 3 and numbers[3] == nil)
    end)

    it('has an optional step', function()
        numbers = {}
        for v = 1, 2 do
            numbers[#numbers + 1] = v
        end
        assert(numbers[1] == 1 and numbers[2] == 2 and numbers[3] == nil)
    end)
end)


describe('A generic for loop', function()
    it('Loops over iterators', function()
        array = {1, 2, 3}
        sum = 0
        for number in pairs(array) do
            sum = sum + number
        end
        assert(sum == 6)
    end)
end)


describe('Return', function()
    xit('sadly must be the last statement in a block')
end)


describe('A variable', function()
    xit('sadly can be accessed when not defined')
end)


--Why does this work?: table = {a=1}; assert(#table == 0)
--Why isn't this valid syntax?: assert({a=1} != {a=1})


--[[
    Bug in manual section 2.2:
    "Like indices, the value of a table field can be of any type (except nil)"
    Values can be nil!
    ]]


--[[
    LANGUAGE NOTES

    1) Using tables as objects seems to disallow the language to (1) define
       table equality and (2) allow sentinel object creation. If empty tables
       are equal, and objects are tables, then two new objects will equal
       each other, so they can't be used as sentinels. If two new objects
       don't equal each other, then table equality isn't defined properly.
   ]]

