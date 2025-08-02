-- lua/plugins/luasnip.lua
return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*', -- use the stable v2 release
  build = 'make install_jsregexp', -- for regex support in snippets
  dependencies = {
    'rafamadriz/friendly-snippets', -- optional: for many pre-made snippets
  },
  config = function()
    local ls = require 'luasnip'
    local types = require 'luasnip.util.types'

    ls.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
          },
        },
      },
    }

    -- Load VSCode-style snippets from friendly-snippets or your own
    require('luasnip.loaders.from_vscode').lazy_load { paths = '~/.config/nvim/snippets' }
    -- Optionally, load snippets from Lua files
    -- require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/snippets' }

    -- Optional keybindings (change to fit your layout)
    -- vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    --   if ls.expand_or_jumpable() then
    --     ls.expand_or_jump()
    --   end
    -- end, { silent = true })
    --
    -- vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    --   if ls.jumpable(-1) then
    --     ls.jump(-1)
    --   end
    -- end, { silent = true })
    --
    -- vim.keymap.set('i', '<C-l>', function()
    --   if ls.choice_active() then
    --     ls.change_choice(1)
    --   end
    -- end)
  end,
}
