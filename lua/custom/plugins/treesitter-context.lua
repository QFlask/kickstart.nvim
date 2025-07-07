return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'VeryLazy', -- or "BufReadPre" if you want earlier loading
  enabled = true,
  config = function()
    require('treesitter-context').setup {
      enable = true, -- Enable this plugin (can be toggled with :TSContextToggle)
      max_lines = 5, -- How many lines the context window should span
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded
      min_window_height = 0, -- Minimum editor window height to enable context (0 = always on)
      mode = 'cursor', -- Line used to calculate context. "cursor" or "topline"
      separator = nil, -- String between context and content. Set to "-" or "─"
      zindex = 20, -- Z-index of the context window
      on_attach = nil, -- Custom function to attach this plugin
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
}
