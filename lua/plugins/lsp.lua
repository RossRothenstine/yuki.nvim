return {
	{
		'neovim/nvim-lspconfig',
		{
			{ 'williamboman/mason.nvim', opts = {} },
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim', opts = {} },
			'saghen/blink.cmp',
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local utils = require('utils')
					local map = utils.map
					local nmap = function(lhs, rhs, desc)
						_map('n', lhs, rhs, { desc = 'LSP: ' .. desc })
					end

					nmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')
					nmap('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')
					nmap('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
					nmap('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
					nmap('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
					nmap('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					nmap('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
					nmap('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
					nmap('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
				end,
			})

			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local servers = {
				clangd = {},
				gopls = {},
				rust_analyzer = {},
				lua_ls = {},
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			require('mason-lspconfig').setup {
				ensure_installed = ensure_installed,
				automatic_installation = true
			}
		end,
	}
}
