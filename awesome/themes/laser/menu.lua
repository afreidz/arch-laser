local awful = require('awful')
local beautiful = require('beautiful')
local logout_cmd = 'pkill xinit'
local restart_cmd = 'reboot'
local shutdown_cmd = 'shutdown now'

return function()
  local menu = awful.menu({
    items = {
      { 'Shutdown', shutdown_cmd, beautiful.menu_shutdown },
      { 'Restart', restart_cmd, beautiful.menu_restart },
      { 'Logout', logout_cmd, beautiful.menu_logout },
    }
  })
  return menu
end 