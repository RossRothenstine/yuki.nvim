-- Various utilities.
return {
  -- Which key: Helps figure out available keybinds.
  -- See: :help which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer local keymaps (which key)',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
      })
    end,
  },
  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
        shared_tree_across_tabs = true,
        window = {
          mappings = {
            ['<Tab>'] = function(state)
              local node = state.tree:get_node()
              if require('neo-tree.utils').is_expandable(node) then
                state.commands['toggle_node'](state)
              else
                state.commands['open'](state)
                vim.cmd('Neotree reveal')
              end
            end,
          },
        },
      })
      -- Key mappings
      local map = require('utils').map
      map('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })
    end,
  },
  -- Automatic session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    config = function()
      require('persistence').setup({
        dir = vim.fn.stdpath('state') .. '/sessions',
        options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
      })

      if vim.fn.argc() == 0 then
        require('persistence').load()
      end

      local map = require('utils').map

      -- Key bindings
      map('n', '<leader>ss', function()
        require('persistence').load()
      end)
      map('n', '<leader>sl', function()
        require('persistence').load({ last = true })
      end)
      map('n', '<leader>sd', function()
        require('persistence').stop()
      end)
    end,
  },
  'folke/noice.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-sensible',
  'tpope/vim-sleuth',
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  'lewis6991/gitsigns.nvim'
}
