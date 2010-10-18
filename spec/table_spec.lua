describe('A table', function()
    it('allows element access with brackets or dot', function()
        local table = {a=1, b=2}
        assert(table['a'] == 1 and table.a == 1)
    end)

    it('is writeable', function()
        local table = {}
        table['a'] = 1
        table.b = 2
        assert(table.a == 1 and table.b == 2)
    end)

    it('does not allow nil keys', function()
        local table = {}
        assert_raises(function() table[nil] = 1 end)
    end)

    it('allows nil values', function()
        local table = {a=nil}
        assert(table.a == nil)
    end)

    it('sadly returns nil by default', function()
        local table = {}
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
        local inner_table = {'the inner table'}
        local table = {[inner_table]=5}
        local next_fn = pairs(table)
        local key = next_fn(table)
        assert(key[1] == 'the inner table')
    end)

    it('can have trailing separators', function()
        local table = {'a', 'b',}
        assert(table[2] == 'b')
    end)
end)


describe('A table used as an array', function()
    it('has a size', function()
        assert(#{1, 2, 3} == 3)
    end)

    it('sadly begins indexing at 1', function()
        local array = {'x'}
        assert(array[1] == 'x')
    end)

    it('contains elements in order', function()
        local array = {10, 20, 30}
        assert(array[1] == 10 and array[2] == 20 and array[3] == 30)
    end)

    it('can contain duplicate elements', function()
        local array = {10, 20, 10}
        assert(array[1] == array[3])
    end)

    xit('sadly considers any nil element as the end_ of the list', function()
        -- I can't find an example to make this pass, but the manual claims
        -- that it's true. The following fails:
        -- assert(#{1, 2, nil, 3} == 2)
    end)
end)

