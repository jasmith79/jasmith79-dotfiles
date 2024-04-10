local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- colorschemes I like
-- config.color_scheme = 'Blazer'
config.color_scheme = 'rose-pine'

-- default window size
config.initial_cols = 220
config.initial_rows = 60

-- fonty mcfonterson
config.font_size = 12
config.font = wezterm.font_with_fallback {
    { family = 'Monaco', style = 'Normal', harfbuzz_features = { 'zero' }, weight = 'Medium' },
    { family = 'Oxygen Mono', style = 'Normal' },
}

config.keys = {
    -- Turn off the default CTRL-V paste, allowing for visual block
    -- mode in neovim. TODO: figure out Linux solution here.
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DisableDefaultAssignment,
    },
}

config.hide_tab_bar_if_only_one_tab = true

config.disable_default_mouse_bindings = true
config.default_cwd = wezterm.home_dir
config.enable_scroll_bar = true
config.scrollback_lines = 2000
return config
