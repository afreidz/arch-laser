local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local theme_path = './themes/laser'
require('awful.autofocus')
require(theme_path..'/errors')()

local bar = require(theme_path..'/bar')
local menu = require(theme_path..'/menu')
local dashboard = require(theme_path..'/dashboard')
local titlebars = require(theme_path..'/titlebars')
local wallpaper = require(theme_path..'/wallpaper')
local globalkeys = require(theme_path..'/keybinds/global')
local clientkeys = require(theme_path..'/keybinds/client')
local clientbuttons = require(theme_path..'/keybinds/buttons')

-- Set Theme, Default Apps, Modkey
beautiful.init('~/.config/awesome/themes/laser/theme.lua')
terminal = 'termite'
editor = os.getenv('EDITOR') or 'nano'
editor_cmd = terminal .. ' -e ' .. editor
modkey = 'Mod4'

-- Set active layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating
}

-- Setup Elements
local dash = dashboard()
local titlebars = titlebars(client)
local menu = menu()

-- Setup Wallpaper and Layout for each screen
awful.screen.connect_for_each_screen(function(s)
	wallpaper(s)
	awful.tag({ 'term', 'web', 'code', 'media' }, s, awful.layout.layouts[1])
	local bar = bar(menu, s)
end)

-- Setup Global Keybinds
local global_keys = globalkeys(modkey, dash)
root.keys(global_keys)

-- Apply everything to clients via rules
awful.rules.rules = {
	{ rule = { },
	  properties = { 
		border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		focus = awful.client.focus.filter,
		raise = true,
		keys = clientkeys(modkey),
		buttons = clientbuttons(modkey),
		screen = awful.screen.preferred,
		placement = awful.placement.no_overlap+awful.placement.no_offscreen,
		titlebars_enabled = true
	 }
	}
}

-- Handle spawning client via signal
client.connect_signal('manage', function (c)
	if awesome.startup
	  and not c.size_hints.user_position
	  and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)
