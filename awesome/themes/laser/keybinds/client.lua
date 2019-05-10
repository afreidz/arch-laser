local gears = require('gears')
local awful = require('awful')

return function(modkey) 
  return gears.table.join(

    awful.key({ modkey }, 'w', function (c) 
      c:kill()
    end, { description = 'close focused client', group = 'client' }),

    awful.key({ modkey }, 'f',  function (c)
      c.floating.toggle()
    end, { description = 'float toggle focused client', group = 'client' }),
    
    awful.key({ modkey }, 'm', function (c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = 'maximize/minimize focused client', group = 'client' })

  )
end
