ran, pending = 0, 0, 0


function describe(name, callable)
    print(name)
    callable()
end


function it(name, callable)
    print("  - "..name)
    callable()
    ran = ran + 1
end


function xit(name, callable)
    print("  (PENDING) "..name)
    pending = pending + 1
end


function before(callable)
    callable()
end


function assert_raises(callable)
    ok, error = pcall(callable)
    assert(ok == false)
end


function summary()
    print()
    print('Ran '..ran..' specs ('..pending..' pending)')
end

