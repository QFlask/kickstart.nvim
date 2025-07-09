local function setupCustomHighlightGroup()
  vim.api.nvim_command 'hi clear FlashMatch'
  vim.api.nvim_command 'hi clear FlashCurrent'
  vim.api.nvim_command 'hi clear FlashLabel'

  vim.api.nvim_command 'hi FlashMatch guibg=#4A47A3 guifg=#B8B5FF' -- Emerald background
  vim.api.nvim_command 'hi FlashCurrent guibg=#456268 guifg=#D0E8F2'
  vim.api.nvim_command 'hi FlashLabel guibg=#A25772 guifg=#EEF5FF'
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    highlight = {
      backdrop = true,
      groups = {
        match = 'FlashMatch',
        current = 'FlashCurrent',
        backdrop = 'FlashBackdrop',
        label = 'FlashLabel',
      },
    },
  },
  config = function()
    setupCustomHighlightGroup()
  end,
	-- stylua: ignore
	keys = {
		{ "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "<leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "<leader>R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	--	{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
