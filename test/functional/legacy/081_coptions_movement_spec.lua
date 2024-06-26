-- Test for t movement command and 'cpo-;' setting

local t = require('test.functional.testutil')()
local clear, feed, insert = t.clear, t.feed, t.insert
local feed_command, expect = t.feed_command, t.expect

describe('coptions', function()
  setup(clear)

  -- luacheck: ignore 613 (Trailing whitespace in a string)
  it('is working', function()
    insert([[
      aaa two three four
          zzz
      yyy   
      bbb yee yoo four
      ccc two three four
      ddd yee yoo four]])

    feed_command('set cpo-=;')

    feed('gg0tt;D')
    feed('j0fz;D')
    feed('j$Fy;D')
    feed('j$Ty;D')

    feed_command('set cpo+=;')

    feed('j0tt;;D')
    feed('j$Ty;;D')

    expect([[
      aaa two
          z
      y
      bbb y
      ccc
      ddd yee y]])
  end)
end)
