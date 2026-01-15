-- Pull in the wezterm API
local wezterm = require('wezterm')
-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { '/bin/zsh', '-l' }
-- This is where you actually apply your config choices.
config.font_size = 19
config.line_height = 1.2
--config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font = wezterm.font_with_fallback({
  -- 1. Your primary coding font
  { family = 'MesloLGS Nerd Font Mono', weight = 'Regular' },

  -- 2. Fallback for SF Symbols (The 􀧞 icon)
  { family = 'SF Pro', weight = 'Regular' },

  -- 3. Additional fallback for specific symbol variants
  { family = 'SF Symbols', weight = 'Regular' },
})
-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
-- config.window_close_confirmation = 'ConfirmedOnly'

config.quick_select_patterns = {
  -- match things that look like sha1 hashes
  -- (this is actually one of the default patterns)
  '[0-9a-f]{7,40}',
}
-- or, changing the font size and color scheme.
config.color_scheme = 'tokyonight_night'
config.window_decorations = 'RESIZE'
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- Treat Left Option as Alt (Meta)
config.send_composed_key_when_left_alt_is_pressed = false

-- Keep Right Option for special characters (like # or @)
config.send_composed_key_when_right_alt_is_pressed = true
config.colors = {

  cursor_bg = '#7aa2f7',
  cursor_border = '#7aa2f7',
}
config.debug_key_events = true
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'd',
    mods = 'CMD | SHIFT',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'k',
    mods = 'CMD ',
    action = wezterm.action.SendString('clear\n'),
  },
  { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },
  {
    key = 'a',
    mods = 'CTRL|SHIFT|CMD',
    action = wezterm.action_callback(function(window, pane)
      wezterm.run_child_process({ 'shortcuts', 'run', 'New Reminder' })
    end),
  },
}

-- Finally, return the configuration to wezterm:
return config
