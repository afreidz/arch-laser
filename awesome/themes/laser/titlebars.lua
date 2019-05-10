local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

return function(client)
  client.connect_signal('request::titlebars', function(c)
    local buttons = gears.table.join(
      awful.button({ }, 1, function()
        c:emit_signal('request::activate', 'titlebar', {raise = true})
        awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
        c:emit_signal('request::activate', 'titlebar', {raise = true})
        awful.mouse.client.resize(c)
      end)
    )
    
    awful.titlebar(c, { size = 35 }) : setup {
      layout = wibox.layout.align.horizontal,
      expand = 'inside',
      {
        layout = wibox.layout.fixed.horizontal
      },
      {
        layout = wibox.layout.fixed.horizontal
      },
      {
        layout = wibox.layout.fixed.horizontal,
        { 
          awful.titlebar.widget.floatingbutton(c),
          layout = wibox.container.margin(nil, 10, -8, 2, 2)
        },
        { 
          awful.titlebar.widget.maximizedbutton(c),
          layout = wibox.container.margin(nil, 10, -8, 2, 2)
        },
        { 
          awful.titlebar.widget.closebutton(c),
          layout = wibox.container.margin(nil, 10, 8, 2, 2)
        }
      }
    }
  end)

  client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
end