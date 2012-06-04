--///  Main
theme = {"arch"}
--theme.wallpaper_cmd = { "awsetbg -a /home/sergiu/.config/awesome/wallpapers/responsibleparents.jpg" }
theme.wallpaper_cmd = { "awsetbg -r /home/sergiu/Pictures/National_Geographic/" }
--//

--/// Change the wallpaper randomly after a (relatively random) time
-- seed and "pop a few"
math.randomseed( os.time())
for i=1,1000 do tmp=math.random(0,1000) end

x = 0

-- setup the timer
 mytimer = timer { timeout = x }
 mytimer:add_signal("timeout", function()

-- tell awsetbg to randomly choose a wallpaper from your wallpaper directory
 os.execute("awsetbg -r /home/sergiu/Pictures/National_Geographic/")

-- stop the timer (we don't need multiple instances running at the same time)
 mytimer:stop()

-- define the interval in which the next wallpaper change should occur in seconds
-- (in this case anytime between 10 and 20 minutes)
 x = math.random(600, 1200)

--restart the timer
 mytimer.timeout = x
 mytimer:start()
end)

-- initial start when rc.lua is first run
 mytimer:start()
--//

--/// Styles
theme.font      = "clear bold 7"
themedir	= awful.util.getdir("config") .. "/themes2/"
icon_dir 	= awful.util.getdir("config") .. "/icons2/"
--//

--/// Colors
theme.fg_normal = "#CCCCCC"
theme.fg_focus  = "#C0C0C0"
theme.fg_urgent = "#000000"
theme.bg_normal = "#000000"
theme.bg_focus  = "#222815"
theme.bg_urgent = "#ffc0c0"
theme.color_black_dark = "#060606"
theme.color_black_light = "#242424"
theme.color_red_dark = "#BB0000"
theme.color_red_light = "#FF0F0F"
theme.color_green_dark = "#00AA00"
theme.color_green_light = "#00FF00"
theme.color_yellow_dark = "#FF8000"
theme.color_yellow_light = "#FFFF00"
theme.color_blue_dark = "#3333FF"
theme.color_blue_light = "#1793D1"
theme.color_magenta_dark = "#AA00AA"
theme.color_magenta_light = "#CC00CC"
theme.color_cyan_dark = "#00AAAA"
theme.color_cyan_light = "#0FFFFF"
theme.color_white_dark = "#CCCCCC"
theme.color_white_light = "#FFFFFF"
--//

--/// Borders
theme.border_width  = "1"
theme.border_normal = theme.fg_normal
theme.border_focus  = theme.color_blue_light
theme.border_marked = theme.bg_normal
--//

--/// Titlebars
theme.titlebar_fg_normal	= theme.fg_normal
theme.titlebar_fg_focus		= theme.fg_focus
theme.titlebar_bg_normal	= theme.bg_normal
theme.titlebar_bg_focus		= theme.bg_focus
theme.titlebar_font				= "clear bold 7" or "cure 8"
--//

--///
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
theme.taglist_bg_focus = theme.fg_focus
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_bg_not_empty = "#404040"
theme.taglist_fg_not_empty = "#808080"
--theme.tasklist_bg_focus = theme.bg_normal
--//

--/// Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus  = theme.color_blue_light
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus  = theme.color_white_light
theme.menu_border_width = "0"
theme.menu_height = "20"
theme.menu_width  = "150"
--//

--/// Taglist
theme.taglist_squares_sel   = themedir .."/taglist/squarefz.png"
theme.taglist_squares_unsel = themedir .."/taglist/squarez.png"
theme.taglist_squares_resize = "false"
--//

--/// Misc
--theme.awesome_icon           = themedir .."/awesome-icon.png"
--theme.menu_submenu_icon      = "~/.config/awesome/themes2/default/submenu.png"
--theme.tasklist_floating_icon = "~/.config/awesome/themes2/default/tasklist/floatingw.png"
--//

--/// Layout
theme.layout_tile       = themedir .."/layouts/tile.png"
theme.layout_tileleft   = themedir .."/layouts/tileleft.png"
theme.layout_tilebottom = themedir .."/layouts/tilebottom.png"
theme.layout_tiletop    = themedir .."/layouts/tiletop.png"
theme.layout_fairv      = themedir .."/layouts/fairv.png"
theme.layout_fairh      = themedir .."/layouts/fairh.png"
theme.layout_spiral     = themedir .."/layouts/spiral.png"
theme.layout_dwindle    = themedir .."/layouts/dwindle.png"
theme.layout_max        = themedir .."/layouts/max.png"
theme.layout_fullscreen = themedir .."/layouts/fullscreen.png"
theme.layout_magnifier  = themedir .."/layouts/magnifier.png"
theme.layout_floating   = themedir .."/layouts/floating.png"
--//

--/// Titlebar
--[[theme.titlebar_close_button_focus  = themedir .."/close-focused.png"
theme.titlebar_close_button_normal = themedir .."/close-unfocused.png"
theme.titlebar_maximized_button_focus_active  = themedir .."/maximize-focused.png"
theme.titlebar_maximized_button_normal_active = themedir .."/maximize-unfocused.png"
theme.titlebar_maximized_button_focus_inactive  = themedir .."/maximize-focused.png"
theme.titlebar_maximized_button_normal_inactive = themedir .."/maximize-unfocused.png"]]
--//

--////

return theme

