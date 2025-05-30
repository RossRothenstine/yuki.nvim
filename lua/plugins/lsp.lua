-- Main LSP configurations
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
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
          local with_description = function(opts, description)
            local ret = {}
            for k, v in pairs(opts) do
              ret[k] = v
            end
            ret.desc = description
            return ret
          end
          nmap('gD', vim.lsp.buf.declaration, with_description(opts, 'Go to declaration'))
          nmap('gd', vim.lsp.buf.definition, with_description(opts, 'Go to definition'))
          nmap('K', vim.lsp.buf.hover, with_description(opts, 'Hover'))
          nmap('gi', vim.lsp.buf.implementation, with_description(opts, 'Go to implementation'))
          nmap('<C-k>', vim.lsp.buf.signature_help, with_description(opts, 'Signature help'))
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, with_description(opts, 'Add workspace folder'))
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, with_description(opts, 'Remove workspace folder'))
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, with_description(opts, 'List workspace folders'))
          nmap('<leader>D', vim.lsp.buf.type_definition, with_description(opts, 'Type definition'))
          nmap('<leader>rn', vim.lsp.buf.rename, with_description(opts, 'Rename'))
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code action' })
          nmap('gr', vim.lsp.buf.references, with_description(opts, 'References'))
          nmap('<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, with_description(opts, 'Format buffer'))
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
        automatic_enable = false,
        -- Automatically install these LSP servers
        ensure_installed = {
          'clangd',        -- C/C++
          'lua_ls',        -- Lua
          'pyright',       -- Python
          'rust_analyzer', -- Rust
          'ts_ls',         -- TypeScript/JavaScript
          'gopls',         -- Go
          'html',          -- HTML
          'cssls',         -- CSS
          'jsonls',        -- JSON,
          'csharp_ls',     -- C#
        },
      })

      lspconfig.clangd.setup({
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'compile_commands.json',
            'compile_flags.txt',
            '.git',
            'CMakeLists.txt'
          )(fname) or vim.fn.getcwd()
        end,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })

      lspconfig.gdscript.setup({})

      -- Install additional tools via Mason
      require('mason-tool-installer').setup({
        ensure_installed = {
          'clang-format',          -- C/C++ formatter
          'cpplint',               -- C/C++ linter
          -- 'cppcheck', -- C/C++ static analyzer
          'cmake-language-server', -- CMake language server
          'codelldb',              -- Debugger for C/C++
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
