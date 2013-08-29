-- {{{ Load libraries
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Others library
require("freedesktop.utils")
require("freedesktop.menu")
require("widgets")
require("volume")
require("mpd")
require("lfs")

-- Load Debian menu entries
--require("debian.menu")
-- }}}



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}



-- {{{ Default apps
exec = awful.util.spawn
sexec = awful.util.spawn_with_shell
terminal = "urxvtc"
-- terminal2 = "xterm"
cli_editor = "vim"
gui_editor = "medit"
browser = "google-chrome"
gui_fm = "nemo"
cli_fm = terminal .. " -g 100x50 -e mc"
instant_messenger = terminal .. ' -title "Finch" -e finch'
irc = terminal .. ' -title "Weechat" -e weechat-curses'
tvmaxe = terminal .. ' -title "Tvmaxe" -e tvmaxe-cli'
system_monitor = terminal .. ' -e bash -c "htop -u sergiu -s res"'
media_player = "smplayer"
music_player = terminal .. " -e ncmpcpp"
smallterminal = terminal .. ' -title "SmallTerm"  -geometry 90x7-200-100'
--smallterminal = "xterm -geometry 90x7-200-100"
gtk_settings = "lxappearance"
-- }}}




-- {{{ Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
-- }}}



-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,             --1
    awful.layout.suit.tile.bottom,      --2
    awful.layout.suit.fair,             --3
    awful.layout.suit.tile.top,         --4
    awful.layout.suit.spiral,           --5
    awful.layout.suit.magnifier,        --6
    awful.layout.suit.max,              --7
    awful.layout.suit.floating,         --8
    awful.layout.suit.tile.left,        --9
    awful.layout.suit.fair.horizontal,  --10
    awful.layout.suit.spiral.dwindle    --12
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ "term", "web", "chat", "irc", "misc" }, s, 
            {layouts[1], layouts[7], layouts[7], layouts[7], layouts[2]})
end
-- }}}



-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle(desktopmenu_args) end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)))
-- }}}



-- {{{ GLOBAL KEYS BINDINGS
globalkeys = awful.util.table.join(
    -- Focus
    awful.key({ modkey }, "Left",
        function () awful.client.focus.byidx(-1) if client.focus then client.focus:raise() end end),
    awful.key({ modkey }, "Right",
        function () awful.client.focus.byidx( 1) if client.focus then client.focus:raise() end end),

    -- Tag control
---   awful.key({ altkey, "Control" }, "Left",  awful.tag.viewprev ),
---   awful.key({ altkey, "Control" }, "Right", awful.tag.viewnext ),
    awful.key({ modkey,           }, "Up",    function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "Down",  function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, altkey,   }, "Up",    function () awful.client.incwfact( 0.05)  end),
    awful.key({ modkey, altkey,   }, "Down",  function () awful.client.incwfact(-0.05)  end),
    awful.key({ altkey, "Control" }, "Left",  function () awful.tag.incncol( 1)         end),
    awful.key({ altkey, "Control" }, "Right", function () awful.tag.incncol(-1)         end),
    awful.key({ modkey, "Shift"   }, "Up",    function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "Down",  function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Awesome restart and quit
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control" }, "q", awesome.quit),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "Left",  function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Shift" }, "Right", function () awful.client.swap.byidx( 1)  end),
    awful.key({ modkey,         }, "o",     awful.client.urgent.jumpto),

    -- Program shortcuts
    awful.key({ modkey, }, "t", function () exec("tv-maxe", false) end),
--    awful.key({ modkey, }, "t", function () exec(tvmaxe, false) end),
    awful.key({ modkey, }, "x", function () exec(terminal) end),
    awful.key({ modkey, }, "z", function () awful.util.spawn("dmenu_run") end),
    awful.key({ modkey, }, "w", function () exec(browser) end),
    awful.key({ modkey, }, "f", function () exec(cli_fm) end),
    awful.key({ modkey, }, "v", function () exec(media_player) end),
--    awful.key({ modkey, }, "p", function () exec("pidgin", false) end),
    awful.key({ modkey, }, "p", function () exec(instant_messenger, false) end),
    awful.key({ modkey, }, "i", function () exec(irc, false) end),

    --awful.key({ modkey, }, "n", function () exec(music_player) end),
    awful.key({ modkey, }, "u", function () exec("urxvtc -e bash -c 'sudo pacman-color -Syu'") end),
    awful.key({ modkey, }, "y", function () exec("urxvtc -e bash -c 'sudo yaourt -Syua'") end),
    awful.key({ modkey, }, "h", function () exec(system_monitor) end),
    awful.key({ modkey, }, "e", function () exec(gui_editor) end),
    awful.key({ modkey, }, "n", function () exec(music_player, false) end),
    awful.key({ modkey, }, "Return", function () exec(smallterminal, false) end),
    awful.key({ modkey, altkey }, "f", function () exec(gui_fm) end),
    awful.key({ modkey, altkey }, "n", function () exec("nitrogen --sort=alpha") end),
    awful.key({ modkey, altkey }, "a", function () exec(terminal .. " -e alsamixer", false) end),
    awful.key({ }, "XF86PowerOff", function () exec("systemctl poweroff", false) end),
    -- awful.key({ }, "XF86PowerOff", function () exec("sudo poweroff", false) end),
    -- awful.key({ }, "XF86PowerOff", function () exec("sudo pm-hibernate", false) end),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'") end),

    -- Volume Control
    awful.key({ }, "XF86AudioRaiseVolume", function () volumecfg.up() end),
    awful.key({ }, "XF86AudioLowerVolume", function () volumecfg.down() end),
    awful.key({ }, "XF86AudioMute",        function () volumecfg.toggle() end),

    -- MPD control
    awful.key({	modkey, "Control" }, "Up", function () exec("mpc play", false) end),
    awful.key({	modkey, "Control" }, "Down", function () exec("mpc pause", false) end),
    awful.key({ modkey, "Control" }, "Right" , function () exec("mpc next", false) end),
    awful.key({	modkey, "Control" }, "Left" , function () exec("mpc prev", false) end),

    -- Menu
    awful.key({ modkey }, "Escape", function () mymainmenu:toggle(keymenu_args) end),
    awful.key({ altkey }, "Tab",    function () awful.menu.menu_keys.down = { "Down", "Alt_L" }
                                                local cmenu = awful.menu.clients({width=245}, keymenu_args ) end)
)

--/// CLIENT KEYS
clientkeys = awful.util.table.join(
     -- Kill
    awful.key({ modkey }, "c", function (c) c:kill() end),
     -- Floating
    awful.key({ altkey }, "space", awful.client.floating.toggle ),
     -- Swap to master
    awful.key({ altkey }, "Return", function (c) c:swap(awful.client.getmaster()) end),
     -- Redraw
    awful.key({ modkey }, "F1", function (c) c:redraw() end),
     -- Fullscreen
    awful.key({ modkey }, "F11", function (c) c.fullscreen = not c.fullscreen  end),
     -- On Top
    awful.key({ modkey }, "F5", function (c) c.ontop = not c.ontop end),
     -- Remove Titlebars
    awful.key({ modkey }, "F3", function (c) if c.titlebar then awful.titlebar.remove(c) else awful.titlebar.add(c) end end),
     -- Move to center
    awful.key({ modkey }, "#84", function (c) awful.placement.centered(c) end),
    awful.key({ modkey }, "#79", function (c) awful.placement.center_horizontal(c) end),
    awful.key({ modkey }, "#87", function (c) awful.placement.center_vertical(c) end),

     -- Toggle full maximize
    awful.key({ modkey }, "a", function (c) c.maximized_horizontal, c.maximized_vertical = not c.maximized_horizontal, not c.maximized_vertical end),
     -- Toggle vertical maximize
    awful.key({ modkey }, "KP_Next", function (c) c.maximized_vertical = not c.maximized_vertical end),
    -- Toggle horizontal maximize
    awful.key({ modkey }, "KP_Prior", function (c) c.maximized_horizontal = not c.maximized_horizontal end),  

    -- Move clients (up,down,left,right)
    awful.key({ modkey }, "#80", function (c) awful.client.moveresize(  0,-30, 0, 0) end),
    awful.key({ modkey }, "#88", function (c) awful.client.moveresize(  0, 30, 0, 0) end), 
    awful.key({ modkey }, "#83", function (c) awful.client.moveresize(-30, 0,  0, 0) end), 
    awful.key({ modkey }, "#85", function (c) awful.client.moveresize( 30, 0,  0, 0) end),
    -- To margins (up,down,left,right)
    awful.key({modkey,altkey}, "#80", function (c) local g = c:geometry(); g.y = 16; c:geometry(g) end), 
    awful.key({modkey,altkey}, "#88", function (c) local g, screen_area = c:geometry(), screen[c.screen].workarea
                                                        g.y = screen_area.y + screen_area.height - g.height 
                                                        c:geometry(g) end), 
    awful.key({modkey,altkey}, "#83", function (c) local g = c:geometry(); g.x= 0; c:geometry(g) end), 
    awful.key({modkey,altkey}, "#85", function (c) local g, screen_area = c:geometry(), screen[c.screen].workarea
                                                        g.x = screen_area.x + screen_area.width - g.width 
                                                        c:geometry(g) end), 

    -- Resize clients (up,down,left,right)
    awful.key({ altkey, }, "#80", function (c) awful.client.moveresize( 0, 0,  0,-30) end),
    awful.key({ altkey, }, "#88", function (c) awful.client.moveresize( 0, 0,  0, 30) end), 
    awful.key({ altkey, }, "#83", function (c) awful.client.moveresize( 0, 0,-30, 0 ) end), 
    awful.key({ altkey, }, "#85", function (c) awful.client.moveresize( 0, 0, 30, 0 ) end) 
)
-- }}}




-- Compute the maximum number of digit we need, limited to 9
keynumber = 5
--for s = 1, screen.count() do
--   keynumber = math.min(9, math.max(#tags[s], keynumber));
--end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_focus,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                        size_hints_honor = true }, },
   -- { rule = { class = 'URxvt' },
     --   properties = { size_hints_honor = false, tag = tags [1][1] }, },
    { rule = { class = "Google-chrome" },
        properties = { tag = tags[1][2] }, },
    { rule = { class = "Pidgin" },
        properties = { tag = tags[1][3] }, },
    { rule_any = { class = { "Nemo", "Tv-maxe", "medit" }, },
        properties = { tag = tags[1][5] }, },
    { rule = { name = "Finch" },
        properties = { tag = tags[1][3] }, },
    { rule = { name = "Weechat" },
        properties = { tag = tags[1][4] }, },
    { rule = { name = "Tvmaxe" },
        properties = { tag = tags[1][5] }, },
    { rule = { name = "SmallTerm" },
        properties = { floating = true, ontop = true }, },
    { rule_any = { class = { "MPlayer", "Gnome-mplayer", "sxiv", "feh", "Viewnior" }, },
        properties = { floating = true }, },

}
-- }}}



-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}




-- {{{ Run programm once
local function processwalker()
   local function yieldprocess()
      for dir in lfs.dir("/proc") do
        -- All directories in /proc containing a number, represent a process
        if tonumber(dir) ~= nil then
          local f, err = io.open("/proc/"..dir.."/cmdline")
          if f then
            local cmdline = f:read("*all")
            f:close()
            if cmdline ~= "" then
              coroutine.yield(cmdline)
            end
          end
        end
      end
    end
    return coroutine.wrap(yieldprocess)
end

local function run_once(process, cmd)
   assert(type(process) == "string")
   local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

   for p in processwalker() do
      if p:find(process:gsub("[-+?*]", regex_killer)) then
         return
      end
   end
   return awful.util.spawn(cmd or process)
end
-- Usage Example
---run_once("firefox")
---run_once("dropboxd")
-- Use the second argument, if the programm you wanna start, 
-- differs from the what you want to search.
run_once("urxvtd")
--run_once("dropboxd")
-- }}}