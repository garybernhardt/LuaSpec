describe('A closure', function()
    it('closes over variables', function()
        x = {0}
        function f()
            x[1] = x[1] + 1
            return x[1]
        end
        assert(f() == 1)
        assert(f() == 2)
    end)
end)


describe('A block', function()
    it('creates a new environment on each execution', function()
        a = {}
        for i = 1, 2 do
            local closed = {0}
            a[i] = function() closed[1] = closed[1] + 1; return closed[1] end
        end
        assert(a[1]() == 1)
        assert(a[1]() == 2)
        assert(a[2]() == 1)
    end)
end)

