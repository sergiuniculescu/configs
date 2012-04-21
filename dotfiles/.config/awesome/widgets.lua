require("awful")
require("beautiful")
require("vicious")
require("mainmenu")
require("freedesktop.utils")
require("freedesktop.menu")
require("volume")
require("mpd")
require("calendar2")

--beautiful.init("/home/sergiu/.config/awesome/theme.lua")
beautiful.init("/home/sergiu/.config/awesome/theme2.lua")

-- Icon dir
--icon_dir = awful.util.getdir("config") .. "/icons/"
icon_dir = awful.util.getdir("config") .. "/icons2/"

-- MainMenu
mymainmenu = myrc.mainmenu.build()

---mylauncher = awful.widget.launcher({ image = image(icon_dir .. "arch_10x10.png"),
---                                     menu = mymainmenu })

mylauncher = widget({ type = "imagebox" })
mylauncher.image = image(icon_dir .. "arch2.png")
---mylauncher.text = ' <span color="'..beautiful.fg_focus..'" > MENU</span>'
mylauncher:buttons(awful.util.table.join(awful.button({}, 1, nil, function () mymainmenu:toggle(mainmenu_args) end)))
mainmenu_args = { coords={ x=0, y=0 }, keygrabber = true }
desktopmenu_args = { keygrabber = true }
keymenu_args = { coords={ x=200, y=100 }, keygrabber = true }

-- text color
normal_col = 		'<span color="'	..beautiful.fg_normal..'">'
focus_col = 		'<span color="'	..beautiful.fg_focus..'">'
black0_col = 		'<span color="' ..beautiful.color_black_dark..'">'
black1_col = 		'<span color="' ..beautiful.color_black_light..'">'
red0_col = 			'<span color="' ..beautiful.color_red_dark..'">'
red1_col = 			'<span color="' ..beautiful.color_red_light..'">'
green0_col = 		'<span color="' ..beautiful.color_green_dark..'">'
green1_col = 		'<span color="' ..beautiful.color_green_light..'">'
yellow0_col = 	'<span color="' ..beautiful.color_yellow_dark..'">'
yellow1_col = 	'<span color="' ..beautiful.color_yellow_light..'">'
blue0_col = 		'<span color="' ..beautiful.color_blue_dark..'">'
blue1_col = 		'<span color="' ..beautiful.color_blue_light..'">'
magenta0_col =	'<span color="' ..beautiful.color_magenta_dark..'">'
magenta1_col = 	'<span color="' ..beautiful.color_magenta_light..'">'
cyan0_col = 		'<span color="' ..beautiful.color_cyan_dark..'">'
cyan1_col = 		'<span color="' ..beautiful.color_cyan_light..'">'
white0_col = 		'<span color="' ..beautiful.color_white_dark..'">'
white1_col = 		'<span color="' ..beautiful.color_white_light..'">'
null_col = 			'</span>'

--/// Start a layoutbox ///
mylayoutbox = {}
-- Aliases
local textbox = { type = "textbox" }
local imagebox = widget({ type = "imagebox" })

--/// Taglist 
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
    )
--///

--/// Clock widget ///
----datewidget = widget({ type = "textbox" })
----vicious.register(datewidget, vicious.widgets.date, ''..focus_col..'%H:%M %a %d-%m-%Y'..null_col..'',  10)


--/// Date/Clock widget ///
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })
-- Calendar widget to attach to the textclock
calendar2.addCalendarToWidget(mytextclock)


--/// CPU widget ///
-- Icon
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(icon_dir .. "cpu.png")
-- Text
cpuperc = widget({ type = "textbox" })
cpuperc.width = "50"
cpuperc.align = "right"
vicious.register(cpuperc, vicious.widgets.cpu, '$2%'..normal_col..' '..null_col..'$3%', 2)


--/// Mem Widget ///
-- Icon
memicon = widget({ type = "imagebox" })
memicon.image = image(icon_dir .. "mem.png")
-- Text
memwidget = widget({ type = "textbox" })
memwidget.align = "right"
vicious.register(memwidget, vicious.widgets.mem, ' '..normal_col..'$2MB'..null_col..' / $6MB', 2)


--/// Battery widget ///
-- Icon
		--baticon = widget({ type = "imagebox" })
		--baticon.image = image(icon_dir .. "bat_full_01.png")
-- Text
		--batwidget = widget({ type = "textbox" })
		--batwidget.align = "right"
		--vicious.register(batwidget, vicious.widgets.bat, ' '..normal_col..'$2%'..null_col..'', 20, "BAT0")


--/// Systray ///
systray = widget({ type = "systray"})
systray.align = "right"


--/// Net Widget
----neticon = widget({ type = "imagebox" })
----neticon.align = "right"
netwidget = widget({ type = "textbox" })
netwidget.width = "140"
netwidget.align = "right"
vicious.register(netwidget, vicious.widgets.net, 
    function (widget, args)
        if args["{eth0 carrier}"] == 1 
			then 
----				neticon.image = image("/home/sergiu/.config/awesome/icons/usb.png")
				return ' Dn '..normal_col..args["{eth0 down_kb}"]..null_col..'Kb/s / Up '..normal_col..args["{eth0 up_kb}"]..null_col..'Kb/s'
		elseif args["{wlan0 carrier}"] == 1 
			then 
----				neticon.image = image("/home/sergiu/.config/awesome/icons/wifi_01.png")
				return ' D '..normal_col..args["{wlan0 down_kb}"]..null_col..' U '..normal_col..args["{wlan0 up_kb}"]..null_col..''
	    else 
----			neticon.image = image("/home/sergiu/.config/awesome/icons/empty.png")
			return  'Netwok Disabled '
	   		--end
		end
    end, 1)
--///


function escape_xml(text)
	xml_entities = {
		["\""]	= "&quot;",
		["&"]	= "&amp;",
		["'"]	= "&apos;",
		["<"]	= "&lt;",
		[">"]	= "&gt;"
	}

	return text and text:gsub("[\"&'<>]", xml_entities)
end


--/// MPD widget ///
-- Inizialize widgets
mpdwidget = widget({ type = "textbox" })
mpdwidget.align = "left"
mpdicon = widget({ type = "imagebox" })
-- Connect to MPD
mpc = mpd:new()
-- Build mpd widget
function widget_mpd(widget, icon)
	local status = mpc:send('status')
	local state = status.state
	local current = mpc:send('currentsong')
	local artist, title, elapsed, totaltime
	local running = true
	
	-- Icon table
	---local icon_dir = awful.util.getdir("config").."/icons2/"
	local icons = {
		play = icon_dir.."/play.png",
		pause = icon_dir.."/pause.png",
		stop = icon_dir.."/stop.png",
		none = icon_dir.."/empty.png",
		unknow = icon_dir.."/half.png"
	}
	
	-- Get the state and define the icon widget
	if state == "stop" then icon.image = image(icons.stop)
	elseif state == "pause"	then icon.image = image(icons.pause)
	elseif state == "play"	then icon.image = image(icons.play)
	elseif state == nil		then icon.image = image(icons.none)
								 local running = false
	else icon.image = image(icons.unknow)
	end

	-- Get title and artist	
	if running then
		
		-- get artist
		artist = escape_xml(current.artist)
		if artist == nil then artist = "[n/a]" end
		
		-- get title
		title = escape_xml(current.title)
		if title == nil then 
			title = string.gsub(escape_xml(current.file), ".*/", "")
			if title == nil then title = "[n/a]" end
		end
	
		-- Put the text in the widget
		widget.text = string.format("%s%s%s - %s", blue1_col, title, null_col, artist)
	
	else
		widget.text = ' MPD is closed '
	end

end
-- Start mpd widget
widget_mpd(mpdwidget, mpdicon)
-- Define timer and start it
mpdtimer = timer({ timeout = 2 })
mpdtimer:add_signal("timeout", function() widget_mpd(mpdwidget, mpdicon) end)
mpdtimer:start()


--/// Volume icon ///
volicon = widget({ type = "imagebox" })
volicon.image = image(icon_dir .. "spkr_01.png")


--/// Separator ///
sep = widget({ type = "textbox", align = "center" })
sep.text = '<span color="#151515" > | </span>'


--/// DRAW WIDGETS
for s = 1, screen.count() do
    --// Layoutbox //
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)
	))
    --// Taglist //
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    --// I Wibox 
    mywibox = {}
    mywibox[s] = awful.wibox({ position = "top", height = "16", screen = s })
    mywibox[s].widgets = {
        {
            mylauncher, 
	    mytaglist[s], 
	    mpdicon, mpdwidget,
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s], sep,
	mytextclock, sep,
--        datewidget, sep,
	systray, sep,
        volumetext, volicon, sep,   
--        batwidget, baticon, sep,
	memwidget, memicon, sep,
        cpuperc, cpuicon, sep, 
        netwidget, ----neticon,
        layout = awful.widget.layout.horizontal.rightleft
    }
--	mywibox[s].border_width = "1"
--	mywibox[s].border_color = "#3d5454"
--	mywibox[s].width = "1364"
    --//

end
--///
