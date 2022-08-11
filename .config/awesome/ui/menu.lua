-- ## Menu ##
-- ~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local menubar = require("menubar")
local awful = require('awful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local icon_dir = '/usr/share/icons/Papirus/64x64/apps/'


myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

virtualization = {
	{ "Virt-Manager", 'virt-manager', icon_dir .. 'virt-manager.svg' },
	--{ "Vmware Workstation", 'vmware', icon_dir .. 'vmware-workstation.svg' },
}

texteditor = {
	{ "Text Editor", 'geany', icon_dir .. 'geany.svg' },
	{ "Cherrytree", 'cherrytree', icon_dir .. 'cherrytree.svg' },
	{ "Code Editor", 'vscodium', icon_dir .. 'code.svg' },
}

internet = {
	{ "Firefox", 'firefox', icon_dir .. 'firefox.svg' },
	{ "Tor Browser", 'torbrowser-launcher', icon_dir .. 'tor-browser.svg' },
	{ "Qbittorrent", 'qbittorrent', icon_dir .. 'qbittorrent.svg' },
	{ "ThunderBird", 'thunderbird', icon_dir .. 'thunderbird.svg' },
}

appimages = {
	{ "Session", 'session', icon_dir .. 'session-desktop.svg' },
	{ "Stacer", 'stacer', icon_dir .. 'stacer.svg' },
}

media = {
	{ "Mpv", 'mpv', icon_dir .. 'mpv.svg' },
	{ "Audacious", 'audacious', icon_dir .. 'audacious.svg' },
	{ "OBS", 'obs', icon_dir .. 'obs.svg' },
	
}

tools = {
	{ "Nitrogen", 'nitrogen', icon_dir .. 'nitrogen.svg' },
	{ "Qalculate", 'qalculate-gtk', icon_dir .. 'qalculate.svg' },
	{ "Nettwork Manager", 'nm-connection-editor', icon_dir .. 'preferences-system-network.svg' },
	{ "Pavucontrol", 'pavucontrol', icon_dir .. 'yast-sound.svg' },
	{ "Htop", 'xterm -e htop', icon_dir .. 'htop.svg' },
}

applications = {
	{ "Internet", internet, icon_dir .. 'internet-archive.svg' },
	{ "File Manager", 'pcmanfm', icon_dir .. 'system-file-manager.svg' },
	{ "Text Editor", texteditor, icon_dir .. 'text-editor.svg' },
	{ "Media", media, icon_dir .. 'media-player-48.svg' },
	{ "Steam", 'steam', icon_dir .. 'steam.svg' },
	{ "Virtualization", virtualization, icon_dir .. 'variety.svg' },
	{ "Appimages", appimages, icon_dir .. 'AppImage.svg' },
	--{ "Power Settings", 'xfce4-power-manager-settings', icon_dir .. 'xfce4-power-manager-settings.svg' },
}


powermenu = {
	{ "Lock", function() awful.spawn.with_shell('notify-send "👉 Locking system " && sleep 1 && slock') end, icon_dir .. 'system-lock-screen.svg' },
	{ "Logout", function() awful.spawn.with_shell('notify-send "👉 Loging out " && sleep 1 && loginctl terminate-session ${XDG_SESSION_ID-}') end, icon_dir .. 'system-log-out.svg' },
	{ "Suspend", function() awful.spawn.with_shell('notify-send "👉 Suspending 鈴" && sleep 1 && systemctl suspend') end, icon_dir .. 'system-suspend.svg' },
	{ "Hibernate", function() awful.spawn.with_shell('notify-send "👉 Hibernateing " && sleep 1 && systemctl hibernate') end, icon_dir .. 'system-hibernate.svg' },
	{ "Reboot", function() awful.spawn.with_shell('notify-send "👉 Rebooting " && sleep 1 && reboot') end, icon_dir .. 'system-reboot.svg' },
	{ "Poweroff", function() awful.spawn.with_shell('notify-send "👉 Powering Off " && sleep 1 && poweroff') end, icon_dir .. 'system-shutdown.svg' },
} 

mymainmenu = awful.menu(
{
	items = {
	{ "Awesome", myawesomemenu, theme.awesome_icon },
	{ "Applications", applications, icon_dir .. 'apper.svg' },
	{ "Tools", tools, icon_dir .. 'tools-wizard.svg' },
	{ "open terminal", terminal, icon_dir .. 'terminal.svg' },
	{ "Power Menu", powermenu, icon_dir .. 'preferences-system-power.svg'}
	}
}
)

mylauncher = awful.widget.launcher(
{ 
	image = theme.awesome_icon,
	menu = mymainmenu }
)
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
