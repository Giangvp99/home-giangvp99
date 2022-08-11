-- vars/misc
-- ~~~~~~~~~

-- modkey :
--
modkey = "Mod4"

-- modifer keys :
--
shift = "Shift"
ctrl  = "Control"
alt   = "Mod1"

-- apps :
--
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- mouses :
--
leftclick = 1
midclick = 2
rightclick = 3
scrolldown = 4
scrollup = 5
sidedownclick = 8
sideupclick = 9



Languages = {
    { lang = "en", engine = "xkb:au::eng" },
    { lang = "ru", engine = "xkb:ru::rus" },
    { lang = "vn", engine = "Bamboo::Us" }
}
