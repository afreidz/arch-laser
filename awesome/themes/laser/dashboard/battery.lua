local wibox = require('wibox')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')
local spacer = require('./themes/laser/utils/spacer')
local battery_state_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/battery/charging' }
local battery_percentage_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/battery/percentage' }
local battery_charging = false
local refresh = 10

return function()
  local battery_icon = wibox.widget {
    widget = wibox.widget.imagebox,
    image = beautiful.dashboard_battery_100_charging,
    forced_height = 53
  }
  local state_widget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span font="Rubik 20">Charging</span>',
    align = 'center'
  }
  local percentage_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Rubik 13" foreground="#D6D6D6">(100%)</span>'
  }

  awful.widget.watch(battery_state_cmd, refresh, function(w, std, err)
    if std == nil or std == '' then return false end
    battery_charging = toboolean(std:gsub('[\r\n]', ''))
  end)

  awful.widget.watch(battery_percentage_cmd, refresh, function(w, std, err)
    if std == nil or std == '' then return false end
    local number = tonumber(std:gsub('[\r\n]', ''))

    if battery_charging then
      if number >= 95 then 
        battery_icon.image = beautiful.dashboard_battery_100_charging
      elseif number >= 65 then battery_icon.image = beautiful.dashboard_battery_75_charging
      elseif number >= 35 then battery_icon.image = beautiful.dashboard_battery_50_charging
      elseif number >= 10 then battery_icon.image = beautiful.dashboard_battery_25_charging
      else battery_icon.image = beautiful.dashboard_battery_0_charging end

      state_widget:set_markup_silently('<span font="Rubik 20">Charging</span>')
    else
      if number >= 95 then battery_icon.image = beautiful.dashboard_battery_100
      elseif number >= 65 then battery_icon.image = beautiful.dashboard_battery_75
      elseif number >= 35 then battery_icon.image = beautiful.dashboard_battery_50
      elseif number >= 10 then battery_icon.image = beautiful.dashboard_battery_25
      else battery_icon.image = beautiful.dashboard_battery_0 end

      state_widget:set_markup_silently('<span font="Rubik 20">Not Charging</span>')
    end

    percentage_widget:set_markup_silently('<span font="Rubik 13" foreground="#D6D6D6">('..number..'%)</span>')
  end)

  return { -- Draw Full Widget
    layout = wibox.layout.fixed.vertical,

    { -- Battery Icon
      layout = wibox.layout.align.horizontal,
      expand = 'outside',
      spacer(),

      {
        layout = wibox.container.margin(nil, 0, 0, 0, 20),
        battery_icon
      },
      spacer()
    },
    state_widget,
    percentage_widget
  }
end
