return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'none',

        -- TAB: Accept completion item if visible, otherwise fallback
        ['<Tab>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if cmp.is_visible() then
              return cmp.select_and_accept()
            elseif luasnip.expand_or_jumpable() then
              vim.schedule(function()
                luasnip.expand_or_jump()
              end)
              return true
            else
              return false
            end
          end,
          'fallback',
        },

        -- ENTER: Jump forward through snippet placeholders if inside one
        ['<CR>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.jumpable(1) then
              vim.schedule(function()
                luasnip.jump(1)
              end)
              return true
            -- elseif cmp.is_visible() then
            --   return cmp.select_and_accept()
            else
              return false
            end
          end,
          'fallback',
        },

        -- SHIFT-TAB: Jump backward through snippet placeholders
        ['<S-Tab>'] = {
          function(cmp)
            local luasnip = require 'luasnip'
            if luasnip.jumpable(-1) then
              vim.schedule(function()
                luasnip.jump(-1)
              end)
              return true
            elseif cmp.is_visible() then
              return cmp.select_prev()
            else
              return false
            end
          end,
          'fallback',
        },

        -- Optional: keep other keybindings
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
      },

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
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
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'snippets', 'path', 'snippets', 'buffer' },
        providers = {
          snippets = {
            opts = {
              preset = 'luasnip',
            },
          },

          -- Don't show LuaLS require statements when lazydev has items
          lsp = { fallbacks = { 'lazydev' } },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
        },
      },

      -- Appearance settings
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Signature help
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}
