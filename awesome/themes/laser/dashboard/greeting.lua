local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local beautiful = require('beautiful')
local spacer = require('./themes/laser/utils/spacer')
local random_quote_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/quotes/random' }
local refresh = 20

return function()
  local quote_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'left',
    markup = '<span font="Rubik Light Italic 18"></span>'
  }
  local author_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    markup = '<span font="Rubik Bold 12" foreground="#D6D6D6"></span>',
  }
  
  awful.widget.watch(random_quote_cmd, refresh, function(w, std, err)
    local lines = {}
    for s in std:gmatch('[^\r\n]+') do
      table.insert(lines, s)
    end
    quote_widget:set_markup_silently('<span font="Rubik Light Italic 18">'..lines[1]..'</span>')
    author_widget:set_markup_silently('<span font="Rubik Bold 12" foreground="#D6D6D6">'..(lines[2] or '')..'</span>')
  end)
  
  return wibox.widget {
    layout = wibox.layout.align.horizontal,
    expand = 'outside',
    spacer(),
    {
      layout = wibox.container.background,
      bg = beautiful.bg_popup_controls,
      shape =  function(ch,w,h) gears.shape.rounded_rect(ch,w,h,10) end,
      {
        layout = wibox.container.margin(nil, 20, 20, 20, 20),
        {
          layout = wibox.layout.fixed.vertical,
          {
            layout = wibox.container.margin(nil, 10,10,10,10),
            quote_widget
          },
          author_widget
        }
      }
    },
    spacer()
  }
end
