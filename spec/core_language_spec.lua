describe('Operator', function()
    it('sadly uses ~= for not-equal', function()
        assert(1 ~= 2)
    end)
end)


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


describe('A variable', function()
    it('sadly can be accessed when not defined', function()
        assert(this_is_definitely_not_defined == nil)
    end)
end)


describe('Memory management', function()
    xit('sadly supports weak tables with a cryptic __mode field')
end)


