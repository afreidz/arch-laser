local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local gears = require('gears')
local gfs = require('gears.filesystem')
local image_path = '/home/andy/.config/awesome/themes/laser/images'
local theme = {}


--  Theme Variables
theme.font = 'Open Sans Light 12'
theme.cerise = '#EA3469'
theme.cerise_30 = '#EA346980'
theme.dull_blue = '#5139B8'
theme.dull_blue_30 = '#5139B880'
theme.aqua_blue = '#2AB5C6'
theme.aqua_blue_30 = '#2AB5C680'
theme.meteorite = '#341F7A'
theme.meteorite_highlight = '#0000001A'
theme.meteorite_trans = '#341F7ACC'
theme.mirage = '#181B2D'
theme.scooter = '#2CD3E7'
theme.midnight_express = '#212337'
theme.black_pearl = '#1E2132'
theme.foreground = '#ffffff'


--  Backgrounds
theme.bg_normal = theme.midnight_express
theme.bg_focus = theme.meteorite
theme.bg_urgent = theme.scooter
theme.bg_popup = theme.meteorite_trans
theme.bg_popup_controls = '#00000040'
theme.bg_bar = theme.meteorite
theme.bg_volume = theme.aqua_blue_30
theme.bg_disk = theme.cerise_30
theme.bg_memory = theme.dull_blue_30
theme.bg_info = theme.dull_blue
theme.bg_alert = theme.cerise


--  Foregrounds
theme.fg_normal = theme.foreground
theme.fg_focus = theme.foreground
theme.fg_urgent = theme.foreground
theme.fg_minimize = theme.foreground
theme.fg_volume = theme.aqua_blue
theme.fg_disk = theme.cerise
theme.fg_memory = theme.dull_blue


--  Borders
theme.border_width  = 0
theme.useless_gap   = 15
theme.border_normal = theme.black_pearl
theme.border_focus  = theme.mirage
theme.border_marked = theme.black_pearl
theme.border_bar = theme.mirage


--  Client Shape
-- client.connect_signal("manage", function (c) 
--     c.shape = function (ch, w, h)
--         gears.shape.rounded_rect(ch,w,h,10)
--     end
-- end)


--  Menu Settings
theme.menu_height = 50
theme.menu_width = 200
theme.menu_font = 'Rubik 20'
theme.menu_border_width = 2
theme.menu_bg_normal = theme.meteorite
theme.menu_bg_focus = theme.meteorite_highlight

-- Taglist Settings
theme.taglist_font = 'Fira Code Bold 12'


-- Titlebar Icons
theme.titlebar_close_button_normal = image_path..'/titlebar/Close-inactive.png'
theme.titlebar_close_button_focus  = image_path..'/titlebar/Close-active.png'
theme.titlebar_minimize_button_normal = image_path..'/titlebar/Minimize-inactive.png'
theme.titlebar_minimize_button_focus  = image_path..'/titlebar/Minimize-active.png'
theme.titlebar_floating_button_normal_inactive = image_path..'/titlebar/Float-inactive.png'
theme.titlebar_floating_button_focus_inactive  = image_path..'/titlebar/Float-active.png'
theme.titlebar_floating_button_normal_active = image_path..'/titlebar/Float-inactive.png'
theme.titlebar_floating_button_focus_active  = image_path..'/titlebar/Float-active.png'
theme.titlebar_maximized_button_normal_inactive = image_path..'/titlebar/Maximize-inactive.png'
theme.titlebar_maximized_button_focus_inactive  = image_path..'/titlebar/Maximize-active.png'
theme.titlebar_maximized_button_normal_active = image_path..'/titlebar/Maximize-inactive.png'
theme.titlebar_maximized_button_focus_active  = image_path..'/titlebar/Maximize-active.png'

-- Menu Icons
theme.menu_shutdown = image_path..'/icons/Icon-Shutdown.png'
theme.menu_restart = image_path..'/icons/Icon-Restart.png'
theme.menu_logout = image_path..'/icons/Icon-Logout.png'

-- Dashboard Icons
theme.dashboard_calendar = image_path..'/icons/Icon-Calendar.png'
theme.dashboard_music = image_path..'/icons/Icon-Music.png'
theme.dashboard_battery_100_charging = image_path..'/icons/Icon-Battery-Full-Charging.png'
theme.dashboard_battery_75_charging = image_path..'/icons/Icon-Battery-75-Charging.png'
theme.dashboard_battery_50_charging = image_path..'/icons/Icon-Battery-50-Charging.png'
theme.dashboard_battery_25_charging = image_path..'/icons/Icon-Battery-25-Charging.png'
theme.dashboard_battery_0_charging = image_path..'/icons/Icon-Battery-0-Charging.png'
theme.dashboard_battery_100 = image_path..'/icons/Icon-Battery-Full.png'
theme.dashboard_battery_75 = image_path..'/icons/Icon-Battery-75.png'
theme.dashboard_battery_50 = image_path..'/icons/Icon-Battery-50.png'
theme.dashboard_battery_25 = image_path..'/icons/Icon-Battery-25.png'
theme.dashboard_battery_0 = image_path..'/icons/Icon-Battery-0.png'
theme.dashboard_weather = image_path..'/icons/Icon-Temperature.png'
theme.dashboard_disk_healthy = image_path..'/icons/Icon-Disk-Healthy.png'
theme.dashboard_disk_ok = image_path..'/icons/Icon-Disk-OK.png'
theme.dashboard_disk_critical = image_path..'/icons/Icon-Disk-Critical.png'
theme.dashboard_disk = image_path..'/icons/Icon-Disk.png'
theme.dashboard_memory = image_path..'/icons/Icon-Memory.png'
theme.dashboard_alert = image_path..'/icons/Icon-Alert.png'
theme.dashboard_info = image_path..'/icons/Icon-info.png'
theme.dashboard_headphones = image_path..'/icons/Icon-Headphones.png'
theme.dashboard_headphones_muted = image_path..'/icons/Icon-Headphones-Muted.png'
theme.dashboard_brightness = image_path..'/icons/Icon-Brightness.png'
theme.dashboard_logo = image_path..'/icons/Logo.png'
theme.dashboard_logout = image_path..'/icons/Icon-Logout-full.png'
theme.dashboard_restart = image_path..'/icons/Icon-Restart-full.png'
theme.dashboard_shutdown = image_path..'/icons/Icon-Shutdown-full.png'
theme.dashboard_terminal = image_path..'/icons/Icon-Terminal.png'
theme.dashboard_code = image_path..'/icons/Icon-Code.png'
theme.dashboard_web = image_path..'/icons/Icon-Web.png'
theme.dashboard_media = image_path..'/icons/Icon-Media.png'
theme.dashboard_terminal_inactive = image_path..'/icons/Icon-Terminal-Inactive.png'
theme.dashboard_code_inactive = image_path..'/icons/Icon-Code-Inactive.png'
theme.dashboard_web_inactive = image_path..'/icons/Icon-Web-Inactive.png'
theme.dashboard_media_inactive = image_path..'/icons/Icon-Media-Inactive.png'
theme.wallpaper = image_path..'/wallpaper.jpg'
theme.icon_theme = nil

return theme