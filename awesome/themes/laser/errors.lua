local awful = require('awful')
local naughty = require('naughty')
local notification_post_cmd = 'curl --header "Content-Type:application/json" --request POST -o- http://localhost:1337/notifications'

return function()
  if awesome.startup_errors then
    awful.spawn.easy_async({ 'sh', '-c', notification_post_cmd..' --data \'{ "type": "alert", "source": "AWESOMEWM (startup)", "content": "'..awesome.startup_errors..'" }\''})
  end

  local in_error = false
  awesome.connect_signal('debug::error', function (err)
    if in_error then return end
    in_error = true
    awful.spawn.easy_async({ 'sh', '-c', notification_post_cmd..' --data \'{ "type": "alert", "source": "AWESOMEWM", "content": "'..err..'" }\''}, function()
      in_error = false
    end)
  end)

  naughty.suspend()

end
