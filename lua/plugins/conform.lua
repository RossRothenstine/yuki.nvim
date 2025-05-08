return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        gdscript = { 'gdformat' },
      },
      formatters = {
        gdformat = {
          stdin = false,
          stdout = false,
          args = function(self, ctx)
            return { '$FILENAME' }
          end,
        },
      },
    })
  end,
}
