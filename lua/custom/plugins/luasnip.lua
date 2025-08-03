-- lua/plugins/luasnip.lua
return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  enabled = true, -- ✅ Enabled so blink.cmp can require 'luasnip'
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

    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { vim.fn.stdpath 'config' .. '/snippets' },
    }

    vim.keymap.set({ 'i', 's' }, '<C-l>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = 'Expand snippet or jump to next placeholder' })

    vim.keymap.set({ 'i', 's' }, '<C-h>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = 'Jump to previous snippet placeholder' })

    vim.keymap.set('i', '<C-u>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = 'Cycle through snippet choices' })
  end,
}
