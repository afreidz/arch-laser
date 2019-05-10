local wibox = require("wibox")

return function(size) 
  return wibox.widget {
    widget = wibox.widget.textbox,
    forced_width = size
  }

  -- return wibox.widget {
  --   layout = wibox.container.margin(nil, 10, 10, 10, 10),
  --   color = "#cccccc",
  --   {
  --     widget = wibox.widget.textbox,
  --     forced_width = size
  --   }
  -- }
end