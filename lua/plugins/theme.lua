return {
  -- See :help colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Load color scheme before other plugins
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        term_colors = true,
        transparent_background = false,
        no_italic = false,
        no_bold = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          which_key = true,
          -- For more integrations, see the integration section of the readme
        },
      })
      vim.cmd('colorscheme catppuccin')
    end,
  },
}
