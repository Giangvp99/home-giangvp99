---------------------------
-- Default awesome theme --
---------------------------

-- requirements
-- ~~~~~~~~~~~~
local gfs = require("gears.filesystem")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi


-- Theme Dir :	
local themes_path 								= os.getenv("HOME") .. "/.config/awesome/themes/"

-- Titlebar Dir :
local titlebar_theme 							= "stoplight"
local titlebar_icon_path 						= os.getenv("HOME") .. "/.config/awesome/themes/icons/titlebar/" .. titlebar_theme .. "/"
local tip = titlebar_icon_path

-- Layout Dir :
local layout_icon_path 							= os.getenv("HOME") .. "/.config/awesome/themes/icons/layouts/"
local lip 										= layout_icon_path

-- others Icons :
local others_icon_path 							= os.getenv("HOME") .. "/.config/awesome/themes/icons/others/"
local oip 										= others_icon_path

-- Colors :
colors = {}
-- Dark colors
colors.black 									= "#14181D"
colors.red 										= "#DD4B6A"
colors.green 									= "#87c7a1"
colors.yellow 									= "#de8f78"
colors.blue 									= "#6791c9"
colors.magenta 									= "#bc83e3"
colors.cyan 									= "#70b9cc"
colors.white 									= "#c4c4c4"
-- Bright colors
colors.brightblack 								= "#313E42"
colors.brightred 								= "#ee6a70"
colors.brightgreen 								= "#96d6b0"
colors.brightyellow 							= "#ffb29b"
colors.brightblue 								= "#7ba5dd"
colors.brightmagenta 							= "#cb92f2"
colors.brightcyan 								= "#7fc8db"
colors.brightwhite 								= "#cccccc"
-- Transparent
colors.transparent 								= "#00000000"
colors.container 								= "#1C2325"

theme = {}

theme.font 										= "Cascadia Code Bold 10"
theme.taglist_font 								= "Font Awesome 6 Free Solid 11"
theme.iconfont 									= "Font Awesome 6 Free Solid 10"

theme.bg_normal 								= colors.brightblack
theme.bg_focus  								= colors.brightblack
theme.bg_urgent     							= colors.black
theme.bg_minimize   							= colors.black
theme.bg_systray    							= colors.black
theme.systray_icon_spacing 						= dpi(4)

-- Taglist :
theme.taglist_spacing 							= dpi(2)
theme.taglist_bg_focus                          = colors.black
theme.taglist_fg_focus                          = colors.red
theme.taglist_fg_empty                          = colors.brightblack
theme.taglist_bg_empty                          = colors.black
theme.taglist_fg_urgent							= colors.green

theme.fg_normal     							= colors.white
theme.fg_focus      							= colors.red
theme.fg_urgent     							= colors.brightred
theme.fg_minimize   							= colors.brightblack

-- Clients :
theme.useless_gap   							= dpi(4)
theme.gap_single_client 						= false
theme.border_width  							= dpi(2)
theme.border_normal                             = colors.brightblack
theme.border_focus                              = colors.red
theme.border_marked                             = colors.red

-- Tasklist :
theme.tasklist_bg_normal 						= colors.black
theme.tasklist_bg_focus 						= colors.black
theme.tasklist_bg_urgent 						= colors.red
theme.tasklist_plain_task_name 					= true
theme.tasklist_disable_task_name 				= false
theme.tasklist_disable_icon 					= true

-- Notifications:
theme.notification_position 					= "top_right"
theme.notification_bg 							= colors.black
theme.notification_margin 						= dpi(10)
theme.notification_border_width 				= dpi(10)
theme.notification_border_color	 				= colors.red
theme.notification_spacing 						= dpi(10)
theme.notification_icon_resize_strategy 		= "center"
theme.notification_icon_size 					= dpi(32)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon 						= oip.."forward.png"
theme.menu_bg_normal							= colors.black
theme.menu_bg_focus								= colors.black
theme.menu_border_color 						= colors.red
theme.menu_border_width 						= dpi(2)
theme.menu_height 								= dpi(20)
theme.menu_width  								= dpi(170)


-- Generate Awesome icon:
--theme.awesome_icon = theme_assets.awesome_icon(dpi(70), theme.fg_focus, theme.bg_focus)
theme.awesome_icon  							= oip .."logoarch-cherry.png"
-- Icons :
theme.icon_theme                				= "/usr/share/icons/Papirus-Dark/16x16/apps"
	
-- Titlebar :
theme.titlebar_size 							= dpi(20)
theme.titlebar_position 						= "left"
theme.titlebar_bg_focus                         = colors.black
theme.titlebar_bg_normal                        = colors.black
theme.titlebar_fg_focus                         = colors.red

-- Close Button :
theme.titlebar_close_button_normal 						= tip.."close_normal.svg"
theme.titlebar_close_button_focus  						= tip.."close_focus.svg"

-- Minimize Button :
theme.titlebar_minimize_button_normal 					= tip.."minimize_normal.svg"
theme.titlebar_minimize_button_focus  					= tip.."minimize_focus.svg"

-- Ontop Button :
theme.titlebar_ontop_button_normal_inactive 			= tip.."ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  			= tip.."ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active 				= tip.."ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  				= tip.."ontop_focus_active.svg"

-- Sticky Button :
theme.titlebar_sticky_button_normal_inactive 			= tip.."sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  			= tip.."sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active 				= tip.."sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  				= tip.."sticky_focus_active.svg"

-- Floating Button :
theme.titlebar_floating_button_normal_inactive 			= tip.."floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  			= tip.."floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active 			= tip.."floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  			= tip.."titlebar/stoplight/floating_focus_active.svg"

-- Maximized Button :
theme.titlebar_maximized_button_normal_inactive 		= tip.."maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  		= tip.."maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active 			= tip.."maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  			= tip.."maximized_focus_active.svg"

-- Hovered Close Button
theme.titlebar_close_button_normal_hover 				= tip.. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  				= tip.. "close_focus_hover.svg"

-- Hovered Minimize Buttin
theme.titlebar_minimize_button_normal_hover 			= tip.. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  			= tip.. "minimize_focus_hover.svg"

-- Hovered Ontop Button
theme.titlebar_ontop_button_normal_inactive_hover 		= tip.. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  		= tip.. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover 		= tip.. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  		= tip.. "ontop_focus_active_hover.svg"

-- Hovered Sticky Button
theme.titlebar_sticky_button_normal_inactive_hover 		= tip.. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  		= tip.. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover 		= tip.. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  		= tip.. "sticky_focus_active_hover.svg"

-- Hovered Floating Button
theme.titlebar_floating_button_normal_inactive_hover 	= tip.. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  	= tip.. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover 		= tip.. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  		= tip.. "floating_focus_active_hover.svg"

-- Hovered Maximized Button
theme.titlebar_maximized_button_normal_inactive_hover 	= tip.. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  	= tip.. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover 	= tip.. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  	= tip.. "maximized_focus_active_hover.svg"

-- Wallpaper :
theme.wallpaper 								= themes_path.."wallpapers/background.png"

-- Layoutbox icons :
theme.layout_fairh 								= lip.. "fairh.png"
theme.layout_fairv 								= lip.. "fairv.png"
theme.layout_floating  							= lip.. "floating.png"
theme.layout_magnifier 							= lip.. "magnifier.png"
theme.layout_max 								= lip.. "max.png"
theme.layout_fullscreen 						= lip.. "fullscreen.png"
theme.layout_tilebottom 						= lip.. "tilebottom.png"
theme.layout_tileleft   						= lip.. "tileleft.png"
theme.layout_tile 								= lip.. "tile.png"
theme.layout_tiletop 							= lip.. "tiletop.png"
theme.layout_spiral  							= lip.. "spiral.png"
theme.layout_dwindle 							= lip.. "dwindle.png"
theme.layout_cornernw 							= lip.. "cornernww.png"
theme.layout_cornerne 							= lip.. "cornerne.png"
theme.layout_cornersw 							= lip.. "cornersw.png"
theme.layout_cornerse 							= lip.. "cornerse.png"

return theme
