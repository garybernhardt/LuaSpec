describe('Function', function()
    it('is defineable inline', function()
        local f = function() return 5 end
        assert(f() == 5)
    end)

    --FIXME: move to arguments describe
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
        local truncated = {f(), 'outside'}
        local not_truncated = {f()}
        assert(truncated[1] == 'first' and truncated[2] == 'outside')
        assert(not_truncated[1] == 'first' and not_truncated[2] == 'second')
    end)

    it('sadly has special syntax for calling on tables and strings', function()
        function f(x)
            return 'a '..type(x)
        end
        assert(f{1} == 'a table')
        assert(f'1' == 'a string')
    end)
end)


describe('Return', function()
    it('sadly must be the last statement in a block', function()
        local return_at_end_ok, error = loadstring(
            'while true do return; end')
        local return_in_middle_ok, error = loadstring(
            'while true do return; x = 1; end')
        assert(return_at_end_ok)
        assert(not return_in_middle_ok)
    end)
end)

