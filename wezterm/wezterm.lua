-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
-- config.color_scheme = 'Afterglow'
config.color_scheme = 'Ashes (base16)'

config.enable_scroll_bar = true
config.window_padding = {
	left = 0,
	right = 5,
	top = 0,
	bottom = 0,
}
if wezterm.target_triple:find('windows') then
	config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
end

-- default shell when starting wezterm
if wezterm.target_triple:find('windows') then
	config.default_prog = { 'powershell.exe', '-NoLogo' }
else
	config.default_prog = { '/bin/bash', '-l' }
end

local launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	table.insert(launch_menu, {
		label = 'PowerShell',
		args = { 'powershell.exe', '-NoLogo' },
	})

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in
	ipairs(
		wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files')
	)
	do
		local year = vsvers:gsub('Microsoft Visual Studio/', '')
		table.insert(launch_menu, {
			label = 'x64 Native Tools VS ' .. year,
			args = {
				'cmd.exe',
				'/k',
				'C:/Program Files/'
				.. vsvers
				.. '/Community/VC/Auxiliary/Build/vcvars64.bat',
			},
		})
	end
end

config.launch_menu = launch_menu

-- Finally, return the configuration to wezterm:
return config
