local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')

local get_info_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/count/info' }
local get_alert_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/count/alert' }
local refresh = 1

return function(size)

  local info = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Fira Code '..(size or 15)..'" font-weight="bold">0</span>'
  }
  
  local alert = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Fira Code '..(size or 15)..'" font-weight="bold">0</span>'
  }

  awful.widget.watch(get_info_cmd, refresh, function(w, std, err)
    info:set_markup_silently('<span font="Fira Code '..(size or 15)..'" font-weight="bold">'..std..'</span>')
  end)

  awful.widget.watch(get_alert_cmd, refresh, function(w, std, err)
    alert:set_markup_silently('<span font="Fira Code '..(size or 15)..'" font-weight="bold">'..std..'</span>')
  end)

  local padding = (size or 15) / 3
  local width = (size or 15) * 2
  local height = (size or 15) * 2
  

  return wibox.widget {
    layout = wibox.container.margin(nil, padding, padding, padding, padding),
    {
      layout = wibox.container.background,
      bg = beautiful.bg_info,
      forced_width = width,
      forced_height = height,
      {
        layout = wibox.container.margin(nil, padding, padding, padding, padding),
        info
      }
    }
  },
  {
    layout = wibox.container.margin(nil, padding, padding, padding, padding),
    {
      layout = wibox.container.background,
      bg = beautiful.bg_alert,
      forced_width = width,
      forced_height = height,
      {
        layout = wibox.container.margin(nil, padding, padding, padding, padding),
        alert
      }
    }
  }
end