local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local beautiful = require('beautiful')
local badges = require('./themes/laser/badges')
local spacer = require('./themes/laser/utils/spacer')

local get_info_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/count/info' }
local get_alert_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/count/alert' }
local refresh = 3

return function(menu, screen)

  local tag_update = function(self, tag, index, objects) --luacheck: no unused args
    local icon = self:get_children_by_id('icon_role')[1]
    local isActive = awful.tag.selected(1).name == tag.name

    if(index == 1) then
      if(isActive) then icon.image = beautiful.dashboard_terminal else icon.image = beautiful.dashboard_terminal_inactive end
    end
    if(index == 2) then
      if(isActive) then icon.image = beautiful.dashboard_web else icon.image = beautiful.dashboard_web_inactive end
    end
    if(index == 3) then
      if(isActive) then icon.image = beautiful.dashboard_code else icon.image = beautiful.dashboard_code_inactive end
    end
    if(index == 4) then
      if(isActive) then icon.image = beautiful.dashboard_media else icon.image = beautiful.dashboard_media_inactive end
    end
  end

  local launcher = awful.widget.launcher({
    image = beautiful.dashboard_logo,
    menu = menu
  })

  local taglist = awful.widget.taglist {
    screen = screen,
    filter = awful.widget.taglist.filter.all,
    buttons = awful.button({ }, 1, function(t) t:view_only() end),
    widget_template = {
      layout = wibox.container.margin,
      margins = 4,
      {
        id = 'icon_role',
        align = 'center',
        widget = wibox.widget.imagebox,
      },
      update_callback = tag_update,
      create_callback = tag_update
    }
  }

  local bar_widgets = wibox.widget {
    layout = wibox.layout.align.horizontal,
    expand = 'outside',
    {
      layout = wibox.container.margin(nil, 0,0,0,0),
      {
        layout = wibox.container.background,
        bg = beautiful.bg_bar,
        {
          layout = wibox.layout.align.horizontal,
          expand = 'outside',
          {
            layout = wibox.layout.fixed.horizontal,
            {
              layout = wibox.container.margin(nil, 6,6,6,6),
              launcher
            },
            badges(12)
          },
          taglist,
          spacer()
        }, 
      }
    }
  }


  return awful.wibar {
    stretch = true,
    height = 35,
    position = 'top',
    screen = screen,
    ontop = false,
    bg = beautiful.border_bar,
    widget = bar_widgets,
  }
end