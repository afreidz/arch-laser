local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local spacer = require('./themes/laser/utils/spacer')
local widget_path = './themes/laser/dashboard'
local logout_cmd = 'pkill xinit'
local restart_cmd = 'reboot'
local shutdown_cmd = 'shutdown now'

--  Widgets
local disk = require(widget_path..'/disk')
local song = require(widget_path..'/song')
local memory = require(widget_path..'/memory')
local volume = require(widget_path..'/volume')
local battery = require(widget_path..'/battery')
local weather = require(widget_path..'/weather')
local notifications = require(widget_path..'/notifications')
local icon_size = 31

return function()
  local current = awful.screen.focused()
  local notifications_widget = notifications()

  local shutdown = wibox.widget {
    layout = wibox.container.margin(nil, 20, 20, 20, 20),
    {
      widget = wibox.widget.imagebox,
      image = beautiful.dashboard_shutdown,
      forced_height = icon_size,
      forced_width = icon_size
    },
    buttons = awful.button({ }, 1, function() 
      awful.spawn.easy_async({ 'sh', '-c', shutdown_cmd })
    end)
  }
  
  local restart = wibox.widget {
    layout = wibox.container.margin(nil, 0, 20, 20, 20),
    {
      widget = wibox.widget.imagebox,
      image = beautiful.dashboard_restart,
      forced_height = icon_size,
      forced_width = icon_size
    },
    buttons = awful.button({ }, 1, function() 
      awful.spawn.easy_async({ 'sh', '-c', restart_cmd })
    end)
  }
  local logout = wibox.widget {
    layout = wibox.container.margin(nil, 0, 20, 20, 20),
    {
      widget = wibox.widget.imagebox,
      image = beautiful.dashboard_logout,
      forced_height = icon_size,
      forced_width = icon_size
    },
    buttons = awful.button({ }, 1, function() 
      awful.spawn.easy_async({ 'sh', '-c', logout_cmd })
    end)
  }


  
  local dashboard = awful.popup {
    placement = awful.placement.top_left,
    visible = false,
    ontop = true,
    bg = beautiful.bg_popup,
    
    widget = { -- Shade      
      forced_width = current.geometry.width,
      forced_height = current.geometry.height,
      layout = wibox.container.margin(nil, 20, 20, 20, 20),
      {
        layout = wibox.layout.align.vertical,
        { -- Dashboard Layout
          layout = wibox.layout.align.horizontal,
          {
            layout = wibox.layout.fixed.vertical,
            {
              layout = wibox.container.margin(nil, 0, 0, 0, 20),
              volume(current.geometry.width*0.15),
            },
            {
              layout = wibox.container.margin(nil, 0, 0, 0, 20),
              memory(current.geometry.width*0.15),
            },
            disk(current.geometry.width*0.15),
          },
          { -- Center Content
            layout = wibox.layout.fixed.vertical,
            {
              layout = wibox.layout.fixed.vertical,
              forced_height = 400,
              { -- Clock
                layout = wibox.container.margin(nil, 0, 0, (current.geometry.height*0.1), 0),
                { -- Time
                  align = 'center',
                  widget = wibox.widget.textclock,
                  format = '<span font="Rubik Light 100" font-weight="light">%H %M</span>'
                }
              },
              { -- Cal/Date
                layout = wibox.layout.align.horizontal,
                expand = 'outside',
                spacer(),
                { 
                  layout = wibox.layout.fixed.horizontal,
                  { -- Calendar Icon
                    layout = wibox.container.margin(nil, 0, 20, 10, 0),
                    {
                      widget = wibox.widget.imagebox,
                      image = beautiful.dashboard_calendar,
                      forced_height = icon_size,
                      forced_width = icon_size
                    }
                  },           
                  { -- Date
                    widget = wibox.widget.textclock,
                    format = '<span font="Rubik Light 30" font-weight="light">%A, %B %-m</span>'
                  }
                },
                layout = wibox.layout.align.horizontal,
                expand = 'outside',
                spacer()
              }
            },
            { -- Status Section
              layout = wibox.container.margin(nil, 0, 0, 70, 0),
              forced_height = 230,
              {
                layout = wibox.layout.flex.horizontal,
                song(),
                battery(),
                weather(),
              }
            },
            { -- Notification Section
              layout = wibox.container.margin(nil, (current.geometry.width*0.1), (current.geometry.width*0.1), 0, 0),
              forced_height = 300,
              notifications_widget
            }
          },
          spacer(current.geometry.width*0.15)
        },
        {
          layout = wibox.container.place,
          valign = 'bottom',
          {
            layout = wibox.container.background,
            bg = beautiful.bg_popup_controls,
            {
              layout = wibox.layout.fixed.horizontal,
              shutdown,
              restart,
              logout
            }
          }
        }
      }
    }
  }
  dashboard:connect_signal('dashboard:shown', function()
    notifications_widget:emit_signal('notifications:check')
  end)

  return dashboard
end