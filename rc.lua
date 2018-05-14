-- My AwesomeWM configs
-- Nick Yamane <nick@diegoyam.com>
-- vim: ts=4 sw=4 et
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")     -- Widget and layout library
local beautiful     = require("beautiful") -- Theme handling library
local naughty       = require("naughty")   -- Notification library
local lain          = require("lain")      -- Awesome complements
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Custom util modules
local cyclefocus    = require("utils/cyclefocus")
local collision     = require("collision")()

-- Enable autofocus
require("awful.autofocus")

-- Custom modules configs
if cyclefocus then cyclefocus.display_notifications = false end
if collision  then collision.settings.swap_across_screen = true end

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
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
local chosen_theme      = "darker"
local modkey            = "Mod4"
local altkey            = "Mod1"
local terminal          = "termite"
local editor            = os.getenv("EDITOR") or "vim"
local editor_cmd        = terminal .. " -e " .. editor
local webbrowser        = os.getenv("EDITOR") or "firefox"
local lockscreen        = "/usr/lib/kscreenlocker_greet"
local filemanager       = "ranger"
local filemanager_cmd   = terminal .." -e " .. filemanager
local filemanager_gui   = "nemo"
local toggledisplay     = "~/.bin/toggle-aux-display"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.util.terminal = terminal
awful.util.tagnames = { "code", "term", "web", "chat", "etc" }
awful.layout.layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}
-- }}}

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
                                 os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
local function set_wallpaper(s)
end

screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "w",
        function ()
            local matcher = function (c)
                return awful.rules.match(c, {class = 'Google-chrome', role = 'browser'})
            end
            awful.client.run_or_raise(webbrowser, matcher)
        end),
    awful.key({ modkey,           }, "e", function () awful.util.spawn(filemanager_gui, { width = 800, height = 540 }) end),
    awful.key({ modkey, "Control" }, "l", function () awful.util.spawn(lockscreen) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,           }, "h", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,           }, "l", function () awful.screen.focus_relative(-1) end),

    -- Non-empty tag browsing
    awful.key({ modkey,           }, "j", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ modkey,           }, "k", function () lain.util.tag_view_nonempty(1) end),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "Return", function ()
            awful.spawn(terminal, {}, lain.util.magnify_client)
        end),
    awful.key({ modkey,           }, "BackSpace", function () awful.screen.focused().quake:toggle() end,
              {description = "toggle quake termite"}),
    awful.key({ modkey, "Shift"   }, "BackSpace", function () awful.screen.focused().quake_htop:toggle() end,
              {description = "toggle quake htop"}),
    awful.key({ modkey            }, "=", function () awful.screen.focused().quake_ranger:toggle() end,
              {description = "toggle quake ranger"}),

    awful.key({ modkey,           }, "Home", function()
            awful.spawn.with_shell(toggledisplay)
            awesome.restart()
        end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end),

    awful.key({ modkey, "Shift" }, "n", awful.client.restore),
    awful.key({ modkey, "Control" }, "k", beautiful.kbdwidget.next),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- rename tag
    awful.key({ modkey }, ",",
            function ()
                awful.prompt.run {
                    prompt = " | Rename tab: ",
                    textbox = awful.screen.focused().mypromptbox.widget,
                    exe_callback = function (s)
                        awful.tag.selected().name = s
                    end
                }
            end,
            {description = "Rename current tag", group = "awesome"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Toggle wibox
    awful.key({ modkey }, "b",
        function ()
            myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible
        end,
        {description = "toggle statusbar"}
        ),

    -- Media keys
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 8") end),
    awful.key({ }, "XF86MonBrightnessUp",   function () awful.util.spawn("xbacklight -inc 8") end),

    -- Gaps resizing
    awful.key({ modkey,         }, "g", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ modkey, "Shift" }, "g", function () lain.util.useless_gaps_resize(-1) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  lain.util.magnify_client                         ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "y",      awful.placement.centered),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),

    -- Alt-Tab: cycle through clients on the same screen.
    cyclefocus.key({ altkey, }, "Tab", 1, {
        cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
        keys = {'Tab', 'ISO_Left_Tab'}  -- default, could be left out
    }),
    -- Alt-Shift-Tab: cycle through clients on the same screen.
    cyclefocus.key({ altkey, "Shift" }, "Tab", -1, {
        cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
        keys = {'Tab', 'ISO_Left_Tab'}  -- default, could be left out
    })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           tag:view_only()
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
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

local function nlog(str)
    if use_notif_for_log then
        naughty.notify({
            preset = naughty.config.presets.critical,
            text = str
        })
    else
        gears.debug.print_warning(str)
    end
end

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap +
                                 awful.placement.no_offscreen
     },
     callback = function(c)
         awful.client.setslave(c)
         if not c.class and not c.name then
             local f
             f = function(_c)
                 _c:disconnect_signal("property::name", f)
                 if _c.name == "Spotify" then
                     awful.rules.apply(_c)
                 end
             end
             c:connect_signal("property::name", f)
         end
     end
    },

    { rule_any = {
          instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
          },
          class = {
            "MPlayer",
            "MessageWin",  -- kalarm.
            "Sxiv",
            "Wpa_gui",
            "pinentry",
            "veromix",
            "xtightvncviewer",
            "Nemo",
            "scrcpy"
            },
          name = {
            "Event Tester",  -- xev.
          },
      },
      properties = { floating = true }
    },

    { rule_any = {
          role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          },
          instance = {
            "gcr-prompter"  -- Gnome-keyring (Evolution, etc)
          },
          type = {
            "splash",       -- Gimp, Discord, etc..
            "dialog",       -- Java programs (Android Studio, JD-Gui, etc)
            "pop-up",       -- example (??)
          }
      },
      properties = { floating = true },
      callback = function(c) awful.placement.centered(c) end
    },

    { rule_any = {
          class = {
            "Nemo"
            },
        },
      properties = {
        floating = true,
        placement = awful.placement.centered }
    },

    { rule_any = { class = { "Plank", "lattedock" } },
        properties = {
            border_width = 0,
            floating = true,
            sticky = true,
            focusable = false,
            below = true,
        }
    },

    -- Set Brower/Mail Client to always map on tags number 2 of screen 1.
    { rule_any = { class = { "Firefox" }, instance = { "chromium", "google-chrome" } },
      properties = { 1, tag = "web", switchtotag = true }
    },
    { rule_any = { class = { "Evolution" } },
      properties = { screen = 1, maximized_vertical = true, maximized_horizontal = true }
    },
    { rule_any = {
            class = { "Slack", "Telegram", "discord", "Messenger for Desktop" },
            instance = { "web.whatsapp.com" }
        },
      properties = { screen = 1, tag = "chat", floating = true, switchtotag = true }
    },
    { rule = { name = "Spotify" },
      properties = { screen = 1, tag = "etc", maximized_vertical = true, maximized_horizontal = true, switchtotag = true }
    },
    { rule = { class = "Gimp" },
      properties = { tag = "etc", switchtotag = true, maximized_vertical = true, maximized_horizontal = true }
    },
    { rule = { class = "Conky" },
      properties = { border_width = 0, opacity = 0.5, sticky = true }
    },
    { rule = { name = "DFB X11 system window" },
      properties = { screen = 1 }
    },
    { rule = { name = "Drunkwaiter" },
      properties = { screen = (screen.count() < 3 and 1 or 3) }
    },
    { rule = { class = "pylondemo" },
      properties = { screen = 1 }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus
        c.opacity = 1
    end)
client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
        c.opacity = 0.9
    end)

client.connect_signal("request::activate", function(c, context, hints)
    if c and not c:isvisible() then
        if c.class == 'TelegramDesktop'or c.class == 'discord' or
            c.class == 'Slack' or c.class == 'Messenger for Desktop' then
            c.first_tag:view_only()
            c.minimized = false
            client.focus = c
        end
    end
end)

-- }}}

awful.spawn.with_shell("~/.config/awesome/autorun.sh")

