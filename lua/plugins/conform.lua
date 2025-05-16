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
        go = { 'goimports' },
        rust = { 'rustfmt' },
        gdscript = { 'gdformat' },
        html = { 'prettier' },
        cs = { 'csharpier' },
        xml = { 'xmlformat' },
      },
      formatters = {
        gdformat = {
          stdin = false,
          stdout = false,
          args = function(self, ctx)
            return { '$FILENAME' }
          end,
        },
        csharpier = {
          command = 'dotnet-csharpier',
          args = { '--write-stdout' },
          stdin = true,
        },
        xmlformat = {
          command = 'xmlformat',
          args = { '--selfclose', '-' },
          stdin = true,
        },
      },
    })
  end,
}
