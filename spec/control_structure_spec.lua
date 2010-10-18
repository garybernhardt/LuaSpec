describe('If statement', function()
    it('requires a then', function()
        local x = 0
        if true then
            x = 5
        end
        assert(x == 5)
    end)
end)


describe('While loop', function()
    it('requires a do', function()
        local counter, sum = 0, 0
        while counter < 3 do
            counter, sum = counter + 1, sum + 10
        end
        assert(sum == 30)
    end)
end)


describe('Repeat loop', function()
    -- Vim bug: indentation fails if there's an "until" word in a string
    it('has an _until_ clause', function()
        local counter, sum = 0, 0
        repeat
            counter, sum = counter + 1, sum + 10
        until counter > 3
        assert(sum == 40)
    end)
end)


describe('Break', function()
    it('exits loops', function()
        local x = 0
        while true do
            x = x + 1
            break
        end
        assert(x == 1)
    end)

    it('sadly must be the last statement in a block', function()
        local break_at_end_ok, error = loadstring(
            'while true do break; end')
        local break_in_middle_ok, error = loadstring(
            'while true do break; x = 1; end')
        assert(break_at_end_ok)
        assert(not break_in_middle_ok)
    end)
end)


describe('A numeric for loop', function()
    it('sadly exists', function()
        local numbers = {}
        for v = 1, 3, 2 do
            numbers[#numbers + 1] = v
        end
        assert(numbers[1] == 1 and numbers[2] == 3 and numbers[3] == nil)
    end)

    it('has an optional step', function()
        local numbers = {}
        for v = 1, 2 do
            numbers[#numbers + 1] = v
        end
        assert(numbers[1] == 1 and numbers[2] == 2 and numbers[3] == nil)
    end)
end)


describe('A generic for loop', function()
    it('Loops over iterators', function()
        local array = {1, 2, 3}
        local sum = 0
        for number in pairs(array) do
            sum = sum + number
        end
        assert(sum == 6)
    end)
end)

