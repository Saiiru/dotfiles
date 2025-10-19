return {
	"williamboman/mason.nvim",
	lazy = true,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		-- mason
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "bold",
				width = 0.8,
				height = 0.8,
			},
		})

		-- mason tools intaller
		require("mason-tool-installer").setup({ 
            -- ensure_installed is now managed by the main dotfiles installation scripts
			-- ensure_installed = {
			-- 	-- you can turn off/on auto_update per tool
			-- 	{ "bash-language-server" },
			-- 	{ "lua-language-server" },
			-- 	{ "vim-language-server" },
			-- 	{ "stylua" },
			-- 	{ "editorconfig-checker" },
			-- 	{ "html-lsp" },
			-- 	{ "emmet-ls" },
			-- 	{ "css-lsp" },
			-- 	{ "pyright" },
			-- 	{ "black" },
			-- 	{ "autopep8" },
			-- 	{ "json-lsp" },
			-- 	{ "prettier" },
			-- 	{ "biome" },			
			-- 	{ "typescript-language-server" },
			-- 	{ "js-debug-adapter" },
			-- 	{ "eslint-lsp" },
			-- 	{ "codelldb" },
			-- 	{ "tailwindcss-language-server" },
			-- 	{ "clangd" },
			-- 	{ "clang-format" },
			-- },
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 5, -- at least 5 hours between attempts to install/update
		})

		-- lsp servers (from mason_lspconfig.lua, assuming it's loaded separately)
		-- This part is usually handled by mason-lspconfig.nvim, which will automatically
		-- set up the LSP servers that Mason has installed.
		-- If you have custom LSP configurations, they would go here.
		end
}