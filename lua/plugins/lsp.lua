-- Main LSP configurations
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup()

      local lspconfig = require('lspconfig')

      local map = require('utils').map
      local nmap = function(lhs, rhs, opts)
        map('n', lhs, rhs, opts)
      end

      nmap('<leader>d', vim.diagnostic.open_float)
      nmap('[d', vim.diagnostic.goto_prev)
      nmap(']d', vim.diagnostic.goto_next)
      nmap('<leader>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          nmap('gD', vim.lsp.buf.declaration, opts)
          nmap('gd', vim.lsp.buf.definition, opts)
          nmap('K', vim.lsp.buf.hover, opts)
          nmap('gi', vim.lsp.buf.implementation, opts)
          nmap('<C-k>', vim.lsp.buf.signature_help, opts)
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          nmap('<leader>D', vim.lsp.buf.type_definition, opts)
          nmap('<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          nmap('gr', vim.lsp.buf.references, opts)
          nmap('<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      -- Set up Mason to automatically install LSP servers
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })

      require('mason-lspconfig').setup({
        -- Automatically install these LSP servers
        ensure_installed = {
          'clangd', -- C/C++
          'lua_ls', -- Lua
          'pyright', -- Python
          'rust_analyzer', -- Rust
          'tsserver', -- TypeScript/JavaScript
          'gopls', -- Go
          'html', -- HTML
          'cssls', -- CSS
          'jsonls', -- JSON
        },
      })

      lspconfig.gdscript.setup({})

      -- Install additional tools via Mason
      require('mason-tool-installer').setup({
        ensure_installed = {
          'clang-format', -- C/C++ formatter
          'cpplint', -- C/C++ linter
          -- 'cppcheck', -- C/C++ static analyzer
          'cmake-language-server', -- CMake language server
          'codelldb', -- Debugger for C/C++
        },
      })

      -- Set up other language servers
      require('mason-lspconfig').setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler
          lspconfig[server_name].setup {}
        end,

        -- Override handlers for specific servers
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
              },
            },
          }
        end,
      }
    end,
  },
}
