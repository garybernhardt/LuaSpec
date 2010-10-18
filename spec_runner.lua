function describe(name, callable)
    print(name)
    callable()
end


function it(name, callable)
    print("  - "..name)
    callable()
end


function xit(name, callable)
    print("  (PENDING) "..name)
end


function before(callable)
    callable()
end


function assert_raises(callable)
    ok, error = pcall(callable)
    assert(ok == false)
end
