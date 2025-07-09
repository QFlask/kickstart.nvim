return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Optional: you can customize settings here
      -- open_mapping = [[<leader>t]],
      direction = 'float',
    }

    -- Set terminal keymaps on TermOpen
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd 'autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()'
  end,
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' },
    -- {
    --   '<leader>t',
    --   function()
    --     local cwd = vim.fn.getcwd()
    --     local Terminal = require('toggleterm.terminal').Terminal
    --     local term = Terminal:new {
    --       dir = cwd,
    --       direction = 'float',
    --       hidden = true,
    --     }
    --     term:toggle()
    --   end,
    --   desc = 'Toggle Terminal (cwd)',
    -- },
  },
}

-- return {
--   'akinsho/toggleterm.nvim',
--   version = '*',
--   config = true,
--   keys = {
--     { '<leader>t', '<cmd>ToggleTerm<CR>', desc = 'Toggle Terminal' },
--   },
-- }
