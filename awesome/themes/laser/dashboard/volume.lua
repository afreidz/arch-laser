local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')

local get_vol_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/volume/' }
local set_vol_cmd = 'curl --header "Content-Type:application/json" --request POST -o- http://192.168.56.101:1337/volume'
local mute_vol_cmd = { 'sh', '-c', 'curl --request POST -o- http://192.168.56.101:1337/volume/mute' }
local is_muted_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/volume/mute' }
local refresh = 5

return function(widget_width)
  local value = 0
  local display = ''
  local isMuted = 'false'

  local mute_status = wibox.widget {
    widget = wibox.widget.textbox,
    text = 'MUTE',
    align = 'center'
  }

  local percentage_display = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span font="Fira Code 10">'..display..'</span>'
  }

  local progress_bar = wibox.widget {
    widget = wibox.widget.progressbar,
    max_value = 100,
    forced_width = widget_width or 180,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_volume,
    background_color = beautiful.bg_volume,
    buttons = gears.table.join(
      awful.button({ }, 1, function(w)
        if(isMuted ~= 'true') then
          value = math.min(value + 5, 100)
          awful.spawn.easy_async({ 'sh', '-c', set_vol_cmd..' --data \'{ "volume": "'..value..'%" }\''}, function(std, err)
            local values = {}
            for s in std:gmatch('[^\r\n]+') do
              table.insert(values, s)
            end
            display = values[2]
            value = tonumber(values[1])
            w.widget:set_value(value)
            percentage_display:set_markup_silently('<span font="Fira Code 10">'..display..'</span>')
          end)
        end
      end),
      awful.button({ }, 3, function(w)
        if(isMuted ~= 'true') then
          value = math.max(value - 5, 0)
          awful.spawn.easy_async({ 'sh', '-c', set_vol_cmd..' --data \'{ "volume": "'..value..'%" }\''}, function(std, err)
            local values = {}
            for s in std:gmatch('[^\r\n]+') do
              table.insert(values, s)
            end
            display = values[2]
            value = tonumber(values[1])
            w.widget:set_value(value)
            percentage_display:set_markup_silently('<span font="Fira Code 10">'..display..'</span>')
          end)
        end
      end)
    )
  }

  local icon = wibox.widget {
    widget = wibox.widget.imagebox,
    forced_height = 20,
    image = beautiful.dashboard_headphones,
    buttons = gears.table.join(
      awful.button({}, 1, function(w)
        awful.spawn.easy_async(mute_vol_cmd, function(std, err)
          isMuted = std:gsub('[\r\n]', '')
          progress_bar:set_value(isMuted == 'true' and 0 or value)
          mute_status:set_text((isMuted == 'true') and 'MUTE' or '')
        end)
      end)
    )
  }

  awful.spawn.easy_async(is_muted_cmd, function(std, err)
    isMuted = std:gsub('[\r\n]', '')
    mute_status:set_text((isMuted == 'true') and 'MUTE' or '')
  end)

  awful.spawn.easy_async(get_vol_cmd, function(std, err)
    local values = {}
    for s in std:gmatch('[^\r\n]+') do
      table.insert(values, s)
    end

    value = tonumber(values[1])
    display = values[2]
    progress_bar:set_value(isMuted == 'true' and 0 or value)
    percentage_display:set_markup_silently('<span font="Fira Code 10">'..display..'</span>')
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
        {
          layout = wibox.layout.align.horizontal,
          expand = 'outside',
          {
            layout = wibox.container.margin(nil, 2,2,2,2),
            mute_status
          }
        }
      },
      {
        layout = wibox.container.margin(nil, 4,4,0,0),
        percentage_display
      }
    }
  }
end
