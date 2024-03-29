local wezterm = require 'wezterm'
local act = wezterm.action

for _, v in ipairs(wezterm.glob('wezterm.config_dir' .. 'colors')) do
  wezterm.add_to_config_reload_watch_list(v)
end


return {
  font_size = 11.0,
  font = wezterm.font_with_fallback {
    'Hack Nerd Font Mono',
    'Hack Nerd Font',
    'Hack',
    'JetBrains Mono',
    'Noto Color Emoji',
    'Symbols Nerd Font Mono',
  },
  color_scheme = "moonfly",
  window_background_opacity = 0.95,

  use_fancy_tab_bar = false,

  enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,

  scrollback_lines = 10000000,
  enable_kitty_keyboard = true,
  use_ime = true,
  enable_wayland = true,

  show_update_window = false,
  check_for_updates = false,

  warn_about_missing_glyphs=false,

  keys = {
    { key = "f", mods = "CTRL|SHIFT", action = act.Search { Regex = '' } },
  },

  visual_bell = {
    fade_in_duration_ms = 50,
    fade_out_duration_ms = 75,
    target = 'CursorColor',
  },

  window_padding = {
    left = 2,
    right = '0.5cell',
    top = 0,
    bottom = 0,
  },

  -- window_background_gradient = {
  --   orientation = 'Vertical',
  --   colors = {
  --     '#000010',
  --     '#201a52',
  --   },
  --   interpolation = 'Linear',
  --   blend = 'Oklab',
  --   noise = 200,
  -- },
}

