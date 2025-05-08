-- Various utilities.
return {
	-- Which key: Helps figure out available keybinds.
	-- See: :help which-key
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		keys = {
			{
				"<leader>?",
				function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer local keymaps (which key)'
			}
		}
	},
	'tpope/vim-fugitive',
	'tpope/vim-surround',
	'tpope/vim-commentary',
	'tpope/vim-sensible',
	'tpope/vim-sleuth'
}
