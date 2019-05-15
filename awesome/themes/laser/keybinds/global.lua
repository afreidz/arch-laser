local gears = require('gears')
local awful = require('awful')

return function(modkey, dash)
  local global = gears.table.join(
    -- Tags
    awful.key({ modkey }, '1', function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[1]
      if tag then tag:view_only() end
    end, { description = 'focus terminal tag', group = 'tag' }),

    awful.key({ modkey }, '2', function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[2]
      if tag then tag:view_only() end
    end, { description = 'focus web tag', group = 'tag' }),

    awful.key({ modkey }, '3', function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[3]
      if tag then tag:view_only() end
    end, { description = 'focus code tag', group = 'tag' }),

    awful.key({ modkey }, '4', function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[4]
      if tag then tag:view_only() end
    end, { description = 'focus media tag', group = 'tag' }),


    -- Focus
    awful.key({ modkey, 'Alt'}, 'Right', function ()
      awful.client.focus.byidx(1)
    end, { description = 'focus next client', group = 'client' }),

    awful.key({ modkey, 'Alt'}, 'Left', function ()
      awful.client.focus.byidx(-1)
    end, { description = 'focus previous client', group = 'client' }),

    awful.key({ modkey }, 'Left', function () 
      awful.screen.focus_relative(1) 
    end, { description = 'focus next screen', group = 'client' }),

    awful.key({ modkey }, 'Right', function () 
      awful.screen.focus_relative(-1) 
    end, { description = 'focus previous screen', group = 'client' }),

    awful.key({ modkey }, 'u', function ()
      awful.client.urgent.jumpto()
    end, { description = 'jump to urgent client', group = 'client' }),

    awful.key({ modkey }, 'Tab', function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end, { description = 'cycle focus', group = 'client' }),


    -- Move
    awful.key({ modkey, 'Shift' }, 'Left', function () 
      awful.client.swap.byidx(1)
    end, { description = 'move focused client to next', group = 'client' }),

    awful.key({ modkey, 'Shift' }, 'Right', function () 
      awful.client.swap.byidx(-1)
    end, { description = 'move focused client to prev', group = 'client' }),
    
    awful.key({ modkey, 'Control' }, 'n', function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal('request::activate', 'key.unminimize', { raise = true })
      end
    end, { description = 'restore minimized', group = 'client' }),
    
    
    -- Actions
    awful.key({ modkey }, 'Return', function ()
      awful.spawn(terminal) 
    end, { description = 'open a terminal', group = 'action' }),
    
    awful.key({ modkey, 'Control' }, 'r', function ()
      awesome.restart()
    end, { description = 'reload awesome', group = 'action' }),
    
    awful.key({ modkey, 'Shift' }, 'q', function () 
      awesome.quit()
    end, { description = 'quit awesome', group = 'action' }),

    awful.key({ modkey }, 'space', function () 
      awful.spawn('rofi -show drun -theme-str "#prompt-colon { enabled: false; }"')
    end, { description = 'open rofi app launcher', group = 'action' }),

    awful.key({ modkey }, ',', function (c) 
      if dash.visible then
        dash.visible = false
        dash:emit_signal('dashboard:hidden')
      else
        dash.visible = true
        dash:emit_signal('dashboard:shown')
      end
    end, { description = 'display global dashboard', group = 'action' }),

    awful.key({}, 'Escape', function ()
      dash.visible = false
      dash:emit_signal('dashboard:hidden')
    end, { description = 'close dashboard if open', group = 'aciton' }),


    -- Layout
    awful.key({ modkey }, ']', function () 
      awful.tag.incmwfact(0.05)
    end, { description = 'increase master width factor', group = 'layout' }),
    
    awful.key({ modkey }, '[', function () 
      awful.tag.incmwfact(-0.05) 
    end, { description = 'decrease master width factor', group = 'layout' }),

    awful.key({ modkey, 'Control' }, '+', function () 
      awful.tag.incncol(1, nil, true) 
    end, { description = 'increase number of columns', group = 'layout' }),
    
    awful.key({ modkey, 'Control' }, '-', function () 
      awful.tag.incncol(-1, nil, true)
    end, { description = 'decrease number of columns', group = 'layout' })
  )
  return global
end
