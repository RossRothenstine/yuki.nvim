-- Various C++ utilities
return {
  -- Switch between header and source files
  {
    'jakemason/ouroboros.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>o', '<cmd>Ouroboros<CR>', desc = 'Switch Header/Source' },
    },
    config = function()
      require('ouroboros').setup {
        switch_to_open_pane_if_possible = 'true',
      }

      local map = require('utils').map
      map('n', '<leader>o', function()
        require('ouroboros').switch()
      end, { desc = 'Switch between header and source' })
    end,
  },
  -- Supercharging % to match C++ tokens
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 100
      vim.g.matchup_matchparen_deferred_hide_delay = 500
      vim.g.matchup_delim_noskips = 2
      vim.g.matchup_delim_start_plaintext = 0

      -- Better % navigation in C++
      vim.g.matchup_delim_nomids = 1
    end,
  },
}
