return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',

        -- Override specific keys while keeping defaults
        ['<Tab>'] = { 'snippet_forward', 'select_and_accept', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

        -- Keep Enter for selecting next item
        ['<CR>'] = { 'accept', 'fallback' },

        -- Navigation
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },

        -- Documentation
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },

        -- Show/hide completion
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
      },

      -- Use blink.cmp's native snippet expansion (not LuaSnip)
      snippets = {
        preset = 'luasnip',
        expand = function(args)
          require('luasnip').lsp_expand(args)
        end,
        active = function()
          return require('luasnip').jumpable(1) or require('luasnip').jumpable(-1)
        end,
        jump = function(dir)
          require('luasnip').jump(dir)
        end,
      },

      -- Show documentation automatically
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
          },
        },
        list = {
          selection = { preselect = true }, -- Preselect first item (usually snippet)
        },
      },

      -- Use blink.cmp's native snippets source (not luasnip preset)
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
        providers = {
          snippets = {
            name = 'snippets',
            module = 'blink.cmp.sources.snippets',
            score_offset = 100, -- Boost snippet scores to appear first
            opts = {},
          },

          -- Lower priority for LSP to let snippets win
          lsp = {
            fallbacks = { 'lazydev' },
            score_offset = -10, -- Lower LSP priority slightly
          },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },

          -- Even lower priority for buffer completions
          buffer = {
            score_offset = -50,
          },
        },
      },

      -- Appearance settings
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      -- Rust fuzzy matcher for better performance
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Signature help
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}
