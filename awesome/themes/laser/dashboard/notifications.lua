local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local beautiful = require('beautiful')
local badges = require('./themes/laser/badges')
local spacer = require('./themes/laser/utils/spacer')
local greeting = require('./themes/laser/dashboard/greeting')
local notifications_exist_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/exist' }
local get_notifications_cmd = { 'sh', '-c', 'curl -o- http://localhost:1337/notifications/1' }
local dismiss_notification_cmd = 'curl --request POST -o- http://localhost:1337/notifications/dismiss/'
local hasNotifications = false
local refresh = 10

local container = wibox.widget {
  layout = wibox.layout.fixed.vertical,
}

local no_notifications_widget = greeting()

function check ()
  awful.spawn.easy_async(notifications_exist_cmd, function(std, err)
    hasNotificaions = std:gsub('[\r\n]', '') == 'true'
    draw()
  end)
  return container
end
container:connect_signal('notifications:check', check)


function draw ()
  container:reset()

  if(hasNotificaions == false) then
    container:add(no_notifications_widget)
    return container
  end

  local heading = wibox.widget {
    layout = wibox.layout.align.horizontal,
    expand = 'outside',
    spacer(20),
    {
      layout = wibox.container.margin(nil, 0,0,0,20),
      {
        layout = wibox.layout.fixed.horizontal,
        align = 'center',
        {
          widget = wibox.widget.textbox,
          markup = '<span font="Rubik Light 15">Notifications</span>'
        },
        badges(12)
      }
    },
    spacer(20)
  }

  container:add(heading)
  
  awful.spawn.easy_async(get_notifications_cmd, function(std, err)
    for note in std:gmatch('([^~~~]+)') do
      if (note ~= '\n') then
        local lines = {}
        for s in std:gmatch('[^\r\n]+') do
          table.insert(lines, s)
        end
        
        local buttons = gears.table.join(
          awful.button({ }, 1, function()
            awful.spawn.easy_async({'sh', '-c', dismiss_notification_cmd..lines[1] }, function(std, err) 
              check()
            end)
          end)
        )

        local notification_widget = wibox.widget {
          id = lines[1],
          layout = wibox.container.margin(nil, 0,0,0,20),
          buttons = buttons,
          {
            layout = wibox.container.background,
            bg = lines[3] == 'alert' and beautiful.bg_alert or beautiful.bg_info,
            fg = '#ffffff',
            -- forced_height = 160,
            shape =  function(ch,w,h) gears.shape.rounded_rect(ch,w,h,10) end,
            {
              layout = wibox.container.margin(nil, 20, 20, 20, 20),
              {
                layout = wibox.layout.align.horizontal,
                {
                  layout = wibox.container.margin(nil, 0, 20, 10, 0),
                  {
                    widget = wibox.widget.imagebox,
                    image = lines[3] == 'alert' and beautiful.dashboard_alert or beautiful.dashboard_info,
                    forced_height = 51,
                    forced_width = 51
                  }
                },
                {
                  layout = wibox.layout.fixed.vertical,
                  {
                    widget = wibox.widget.textbox,
                    align = 'left',
                    markup = '<span font-weight="bold">'..(lines[4] == 'null' and '' or lines[4])..'</span>'
                  },
                  {
                    widget = wibox.widget.textbox,
                    align = "left",
                    text = lines[5]
                  },
                  {
                    widget = wibox.widget.textbox,
                    align = 'right',
                    markup = '<span font="Open Sans Light 12">'..lines[2]..'</span>'
                  }
                }
              }
            }
          }
        }
        container:add(notification_widget)
      end
    end
  end)

  return container
end

return check
