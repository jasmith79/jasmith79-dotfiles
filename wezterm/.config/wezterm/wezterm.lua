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

config.hide_tab_bar_if_only_one_tab = true

return config
