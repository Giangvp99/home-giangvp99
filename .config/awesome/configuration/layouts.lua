-- ## Layouts ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")


-- layouts
--[[ awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.floating,
    awful.layout.suit.max,
} ]]
-- Tag layout :
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        -- awful.layout.suit.floating,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)


-- tag configs
Tags = {
    { name = "main", layout = awful.layout.layouts[1] },
    { name = "web", layout = awful.layout.layouts[1] },
    { name = "code", layout = awful.layout.layouts[2] },
    { name = "media", layout = awful.layout.layouts[1] },
    -- { name = "chat", layout = awful.layout.layouts[1] },
}

-- ========================================
-- Tags
-- ========================================

local tag_names = {}
local tag_layouts = {}

for i, tag in ipairs(Tags) do
    tag_names[i] = tag.name
    tag_layouts[i] = tag.layout
end

-- Each screen has its own tag table.
awful.screen.connect_for_each_screen(function(s)
    awful.tag(tag_names, s, tag_layouts)
end)
