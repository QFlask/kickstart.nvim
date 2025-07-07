return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- Optional: your custom keymaps
    local function map(key, func, desc)
      vim.keymap.set('n', key, func, { desc = desc or '', noremap = true, silent = true })
    end

    map('<leader>a', function()
      harpoon:list():add()
    end, 'Harpoon: Add file')
    map('<leader>m', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'Harpoon: Quick Menu')
    map('<leader>j', function()
      harpoon:list():select(1)
    end, 'Harpoon: Go to 1')
    map('<leader>k', function()
      harpoon:list():select(2)
    end, 'Harpoon: Go to 2')
    map('<leader>l', function()
      harpoon:list():select(3)
    end, 'Harpoon: Go to 3')
    map('<leader>;', function()
      harpoon:list():select(4)
    end, 'Harpoon: Go to 4')
  end,
}
