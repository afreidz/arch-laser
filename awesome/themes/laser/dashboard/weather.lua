local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')
local spacer = require('./themes/laser/utils/spacer')

local themes_path = '/home/andy/.config/awesome/themes/laser'
local get_weather_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/weather/awesome' }
local update_time = 300

return function ()
  -- Widgets
  local tempWidget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span font="Rubik 50">?°</span>'
  }

  local conditionsWidget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Rubik 20">?</span>'
  }

  local locationWidget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Rubik 13" foreground="#D6D6D6">(?)</span>'
  }

  -- Timers
  gears.timer {
    timeout = update_time,
    call_now = true,
    autostart = true,
    callback = function()
      awful.spawn.easy_async(get_weather_cmd, function(out)
        local lines = {}
        for s in out:gmatch('[^\r\n]+') do
            table.insert(lines, s)
        end
        tempWidget:set_markup_silently('<span font="Rubik 40">'..lines[1]..'°</span>')
        conditionsWidget:set_markup_silently('<span font="Rubik 20">'..lines[2]..'</span>')
        locationWidget:set_markup_silently('<span font="Rubik 13" foreground="#D6D6D6">('..lines[4]..')</span>')
      end)
    end
  }

  -- Draw Full Widget
  return {
    layout = wibox.layout.fixed.vertical,
    { -- Icon
      layout = wibox.layout.align.horizontal,
      expand = 'outside',
      spacer(),

      {
        layout = wibox.layout.fixed.horizontal,
        {
          layout = wibox.container.margin(nil, 0, 10, 10, 20),
          {
            widget = wibox.widget.imagebox,
            image = beautiful.dashboard_weather,
            forced_height = 50
          }
        },
        tempWidget,
      },

      spacer()
    },
    conditionsWidget,
    locationWidget
  }
end
