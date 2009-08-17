-- tdeepequals-autogen.lua: autogenerated random tests for tdeepequals package
-- This file is a part of lua-nucleo library
-- Copyright (c) lua-nucleo authors (see file `COPYRIGHT` for the license)

dofile('lua/strict.lua')
dofile('lua/import.lua')

local make_suite = select(1, ...)
assert(type(make_suite) == "function")

local check_ok = import 'test/lib/tdeepequals-test-utils.lua' { 'check_ok' }
local tserialize = import "lua/tserialize.lua" { 'tserialize' }

local gen_random_dataset,
      mutate =
      import 'test/lib/table.lua'
      {
        'gen_random_dataset',
        'mutate'
      }

--------------------------------------------------------------------------------

local test = make_suite("Autogenerated tests")

--------------------------------------------------------------------------------

for i = 1, 500 do
  test "Random test" (function()
    local c = gen_random_dataset(1)
    check_ok(c, c, true)
  end)
end

for i = 1, 500 do
  test (string.format("Random mutated test#%d",i)) (function()
    local c1 = gen_random_dataset(1)
    local str = tserialize(c1)
    local ch = loadstring(str)
    local rez, c2 = mutate(ch())
    check_ok(c1, c2, not rez)
  end)
end

--------------------------------------------------------------------------------

assert (test:run())
