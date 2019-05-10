local wibox = require('wibox')
local awful = require('awful')
local naughty = require('naughty')
local beautiful = require('beautiful')
local round = require('./themes/laser/utils/round')
local spacer = require('./themes/laser/utils/spacer')
local title_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/song/tile' }
local artist_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/song/artist' }
local refresh = 2

return function()
  local artist_widget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span font="Rubik 20">Nothing playing</span>',
    align = 'center'
  }
  local title_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Rubik 13" foreground="#D6D6D6"> </span>'
  }

  awful.widget.watch(artist_cmd, refresh, function(w, std, err)
    local artist = 'Nothing Playing'
    if string.len(std) ~= 0 then artist = std:gsub('\n', ''):gsub('^%s+', ''):gsub('%s+$', '') end
    artist_widget:set_markup_silently('<span font="Rubik 20">'..artist..'</span>')
  end)

  awful.widget.watch(title_cmd, refresh, function(w, std, err)
    local title = ' '
    if string.len(std) ~= 0 then title = std:gsub('\n', ''):gsub('^%s+', ''):gsub('%s+$', '') end
    title_widget:set_markup_silently('<span font="Rubik 13" foreground="#D6D6D6">'..title..'</span>')
  end)

  return { -- Music Widget
    layout = wibox.layout.fixed.vertical,
    {
      layout = wibox.layout.align.horizontal,
      expand = 'outside',
      spacer(),
      {
        layout = wibox.container.margin(nil, 0, 0, 0, 20),
        {
          widget = wibox.widget.imagebox,
          image = beautiful.dashboard_music,
          forced_height = 53
        }
      },
      spacer()
    },
    artist_widget,
    {
      layout = wibox.layout.align.horizontal,
      expand = 'outside',
      spacer(),
      {
        layout = wibox.container.scroll.horizontal,
        max_size = 300,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        speed = 100,
        title_widget
      },
      spacer(),
    }
  }
end                       
