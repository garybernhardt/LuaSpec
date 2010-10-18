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


describe('A variable argument list', function()
    it('sadly uses ... syntax for definition and reference', function()
        function f(...)
            return ...
        end
        x, y = f(1, 2)
        assert(x == 1 and y == 2)
    end)

    it('sadly is interpolated in assignments', function()
        function f(...)
            x, y, z = 'first', ...
            return z
        end
        assert(f('second', 'third') == 'third')
    end)

    it('sadly is interpolated in table constructors', function()
        function f(...)
            table = {'first', ...}
            return table[3]
        end
        assert(f('second', 'third') == 'third')
    end)
end)

