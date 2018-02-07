---------------------------
-- My "darker" theme --
-- some colors are based on:
-- https://github.com/copycat-killer/awesome-copycats/blob/master/themes/powerarrow
---------------------------

local gears  = require("gears")
local lain   = require("lain")
local awful  = require("awful")
local wibox  = require("/wibox")
local helpers = require("lain.helpers")

local theme = {}

theme.dir           = os.getenv("HOME") .. "/.config/awesome/themes/darker"
theme.font          = "Monaco 8"
theme.font          = "xos4 Terminus 9"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#1E2320"
theme.bg_urgent     = "#ff000088"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal
theme.systray_icon_spacing = 1
theme.wibar_height  = 18

theme.fg_normal     = "#bbbbbb"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#2f2f2f"
theme.border_marked = "#91231c"

theme.tasklist_align = "center"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/nick/.pixmaps/universe-galaxy-red-1920x1200.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_keyboard                           = theme.dir .. "/icons/keyboard.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 0
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.collision_focus_fg = theme.fg_normal
theme.collision_focus_bg = theme.bg_normal
theme.collision_focus_bg_center = theme.bg_normal
theme.collision_shape_width = 30
theme.collision_shape_height = 30
theme.collision_focus_padding = 4
theme.collision_focus_border_width = 4

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "breeze-dark"

local markup = lain.util.markup
local separators = lain.util.separators

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)
local arrl_ll = separators.arrow_left("alpha", "alpha")

local kbdicon = wibox.widget.imagebox(theme.widget_keyboard)

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    ac = "AC",
    timeout = 5,
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, "AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, "AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.font(theme.font, volume_now.level .. "% "))
    end
})

-- Create a textclock and calendar widget
local textclock = wibox.widget.textclock(markup.font(theme.font, "%a %b %d, %H:%M"))
local calendarwidget = lain.widget.calendar {
    attach_to = { textclock },
    followtag = true,
    cal = '/usr/bin/cal -w',
    notification_preset = {
        font = theme.font
    }
}

theme.kbdwidget = lain.widget.contrib.kbdlayout({
    layouts = {
        { layout = "br", variant = "abnt2" },
        { layout = "us", variant = "intl" },
    },
    add_us_secondary = false,
    settings = function()
        widget:set_markup(markup.font(theme.font, kbdlayout_now.layout .. " "))
    end
})

-- Taskwarrior
local taskicon = wibox.widget.imagebox(theme.widget_task)
taskicon:buttons(awful.util.table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))
lain.widget.contrib.task.attach(taskicon, {
    -- do not colorize output
    show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'",
    followtag = true,
    notification_preset = {
        font = theme.font,
    }
})

function theme.at_screen_connect(s)

    -- Create a wibox for each screen and add it
    local taglist_buttons = awful.util.table.join(
                        awful.button({ }, 1, function(t) t:view_only() end),
                        awful.button({ }, 3, awful.tag.viewtoggle),
                        awful.button({ modkey }, 3, function(t)
                                                  if client.focus then
                                                      client.focus:toggle_tag(t)
                                                  end
                                              end),
                        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                    )

    local tasklist_buttons = awful.util.table.join(
                         awful.button({ }, 1, function (c)
                                                  if c == client.focus then
                                                      c.minimized = true
                                                  else
                                                      -- Without this, the following
                                                      -- :isvisible() makes no sense
                                                      c.minimized = false
                                                      if not c:isvisible() and c.first_tag then
                                                          c.first_tag:view_only()
                                                      end
                                                      -- This will also un-minimize
                                                      -- the client, if needed
                                                      client.focus = c
                                                      c:raise()
                                                  end
                                              end),
                         awful.button({ }, 3, function()
                            local instance = nil
                            return function ()
                                if instance and instance.wibox.visible then
                                    instance:hide()
                                    instance = nil
                                else
                                    instance = awful.menu.clients({ theme = { width = 250 } })
                                end
                            end
                         end),
                         awful.button({ }, 4, function ()
                                                  awful.client.focus.byidx(1)
                                              end),
                         awful.button({ }, 5, function ()
                                                  awful.client.focus.byidx(-1)
                                              end))

    -- Wallpaper
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

    local quake_cmd = string.format("env SHOW_ARCHINFO=1 termite --config=%s",
        os.getenv("HOME") .. "/.config/termite/config2")

    s.quake = lain.util.quake({
            app = quake_cmd,
            argname = "--name %s",
            followtag = true,
            width = 1.0,
            height = 0.5,
            overlap = true,
            horiz = "center",
            vert = "top",
            settings = function(c) c.border_width = 0 end
        })

    local quake_htop_cmd = string.format("termite --config=%s -e htop",
        os.getenv("HOME") .. "/.config/termite/config2")

    s.quake_htop = lain.util.quake({
            app = quake_htop_cmd,
            name = "quake_htop",
            argname = "--name %s",
            followtag = true,
            width = 0.7,
            height = 0.5,
            overlap = true,
            horiz = "center",
            vert = "bottom",
            settings = function(c) c.border_width = 0 end
        })

    local quake_ranger_cmd = string.format("termite --config=%s -e ranger",
        os.getenv("HOME") .. "/.config/termite/config2")

    s.quake_ranger = lain.util.quake({
            app = quake_ranger_cmd,
            name = "quake_nemo",
            argname = "--name %s",
            followtag = true,
            width = 0.5,
            height = 0.5,
            overlap = true,
            horiz = "center",
            vert = "bottom",
            settings = function(c) c.border_width = 0 end
        })

    -- Each screen has its own tag table.
    local tags = awful.util.tagnames
    local layouts = awful.layout.layouts
    for i,name in ipairs(tags) do
        awful.tag.add(name, {
            layout = (i <= 3) and layouts[1] or layouts[2],
            screen = s,
            selected = i==1})
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", height = theme.wibar_height, screen = s })

    s.systray = wibox.widget.systray()



    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            spr,
            wibox.container.background(baticon, theme.bg_normal),
            wibox.container.background(bat.widget, theme.bg_normal),
            wibox.container.background(kbdicon, theme.bg_normal),
            wibox.container.background(theme.kbdwidget.widget, theme.bg_normal),
            wibox.container.background(volicon, theme.bg_normal),
            wibox.container.background(theme.volume.widget, theme.bg_normal),
            arrl_ld,
            wibox.container.background(wibox.container.margin(taskicon, 2, 2), theme.bg_focus),
            wibox.container.background(wibox.container.margin(textclock, 2, 3), theme.bg_focus),
            wibox.container.background(spr, theme.bg_focus),
            arrl_dl,
            wibox.container.background(s.mylayoutbox, theme.bg_normal),
        }
    }
end

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
