return {
	{
		-- See :help Telescope
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup {
			}

			local utils = require('utils')
			local map = utils.map
			map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Telescope [F]ind [F]iles'})
			map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Telescope [F]ind [G]rep' })
			map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Telescope [F]ind [B]uffers' })
			map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Telescope [F]ind [H]elp Tags' })
		end
	}
}
