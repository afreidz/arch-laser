local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')

local disk_space_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/disk/status' }
local refresh = 10

return function(widget_width)
  local progress_bar = wibox.widget {
    widget = wibox.widget.progressbar,
    max_value = 100,
    forced_width = widget_width or 180,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_disk,
    background_color = beautiful.bg_disk
  }

  local total = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span font="Fira Code 10">?</span>'
  }
  local used = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Fira Code 10">?</span>'
  }

  local icon = wibox.widget {
    widget = wibox.widget.imagebox,
    forced_height = 20,
    image = beautiful.dashboard_disk,
  }

  awful.widget.watch(disk_space_cmd, refresh, function(w, std, err)
    local values = {}
    for s in std:gmatch('[^\r\n]+') do
      table.insert(values, s)
    end

    local percentage = tonumber(values[3])
    progress_bar:set_value(percentage)
    used:set_markup_silently('<span font="Fira Code 10">'..values[1]..'</span>')
    total:set_markup_silently('<span font="Fira Code 10">'..values[2]..'</span>')
  end)
  
  return {
    layout = wibox.layout.fixed.vertical,
    forced_width = widget_width,
    {
      layout = wibox.layout.align.horizontal,
      forced_height = 20,
      {
        layout = wibox.container.margin(nil, 0, 20, 0, 0),
        icon
      },
      {
        layout = wibox.layout.stack,
        progress_bar,
        used
      },
      {
        layout = wibox.container.margin(nil, 4,4,0,0),
        total
      }
    }
  }
end
