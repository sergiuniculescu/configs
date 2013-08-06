local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop_utils = require("freedesktop.utils")
local freedesktop_menu = require("freedesktop.menu")
local io = io
local table = table
local awesome = awesome
local ipairs = ipairs
local os = os
local string = string
local mouse = mouse
module("myrc.mainmenu")

-- Creates main menu
-- Note: Uses beautiful.icon_theme and beautiful.icon_theme_size
-- env - table with string constants - command line to different apps
function build()
    local terminal = "urxvtc "
    local man = "urxvtc -e man "
    local editor = "urxvtc -e vim "
    local browser = "firefox "
    local run = "dmenu_run "
    local fileman = terminal .. " -e ranger "
    local chat = terminal .. " -e finch "
    local myawesomemenu = { 
        { "Edit config", editor .. awful.util.getdir("config") .. "/rc.lua"},
        { "Edit theme", editor .. awful.util.getdir("config") .. "/theme.lua" },
        { "Edit widgets", editor .. awful.util.getdir("config") .. "/widgets.lua" },
        { "Edit main menu", editor .. awful.util.getdir("config") .. "/mainmenu.lua" },
        { "Restart", awesome.restart },
        { "Stop", awesome.quit } 
    }

    local appmenu_items = {}
    for _, item in ipairs(freedesktop_menu.new()) do table.insert(appmenu_items, item) end
    
    local mymainmenu_items = {
        { "Run", run,  },
        { "Terminal", terminal,  },
        { "Browser", browser,  },
				{ "Chat", chat, },
        { "FileManager", fileman,  },
        { "< AppMenu >", appmenu_items,  },
        { "Awesome", myawesomemenu,  },
    }

    return awful.menu({ items = mymainmenu_items })
end

