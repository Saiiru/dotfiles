-- lua/grimmvim/plugins/ui/colorscheme.lua
-- Plugin + módulo de cores embutido (sem dependências externas)

return {
  {
    "scottmckendry/cyberdream.nvim",
    name = "cyberdream",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      -- borderless_telescope aceita boolean ou tabela; aqui simples:
      borderless_telescope = true,
      theme = { variant = "default", highlights = {} },
      -- outras chaves suportadas pelo tema: extensions, terminal_colors, etc.
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)

      -- ===== módulo de cores embutido =====
      local P = {
        bg   = "#0B0A12",
        surf = "#141127",
        base = "#1A1A2E",
        float= "#1E1E2E",
        text = "#F8F8F2",
        mut  = "#6C7086",
        dim  = "#262533",

        pink = "#FF2D95",
        mag  = "#FF6EC7",
        cyan = "#00F0FF",
        blue = "#00CFFF",
        purp = "#9A6CFF",
        yel  = "#FFD166",
        grn  = "#7CFF00",
        red  = "#FF5555",
      }

      local state = { transparent = true, boost = 1 }
      local function hl(g, o) vim.api.nvim_set_hl(0, g, o) end

      local function apply_core()
        local bg_float = state.transparent and "NONE" or P.float
        local bg_norm  = state.transparent and "NONE" or P.base

        -- UI
        hl("Normal",       { fg = P.text, bg = bg_norm })
        hl("NormalFloat",  { fg = P.text, bg = bg_float })
        hl("FloatBorder",  { fg = P.purp, bg = "NONE" })
        hl("WinSeparator", { fg = "#2a2740", bg = "NONE" })
        hl("LineNr",       { fg = P.mut })
        hl("CursorLine",   { bg = state.transparent and "#17152b" or P.surf })
        hl("CursorLineNr", { fg = P.pink, bold = true })
        hl("ColorColumn",  { bg = "#17152b" })

        -- Menus
        hl("Pmenu",     { bg = "#1a1830", fg = P.text })
        hl("PmenuSel",  { bg = state.boost == 2 and P.mag or P.purp, fg = P.bg, bold = true })
        hl("PmenuSbar", { bg = P.dim })
        hl("PmenuThumb",{ bg = P.cyan })

        -- Treesitter: estilos VSCode-like
        -- Itálico (import/export/from, class/static/new, attrs HTML, comments)
        hl(" @comment",                 { fg = P.purp, italic = true })
        hl(" @keyword",                 { fg = P.pink, italic = true })
        hl(" @keyword.import",          { fg = P.pink, italic = true })
        hl(" @keyword.export",          { fg = P.pink, italic = true })
        hl(" @keyword.modifier",        { fg = P.pink, italic = true })   -- static, etc.
        hl(" @keyword.function",        { fg = P.pink, italic = true })   -- class/def
        hl(" @keyword.storage",         { fg = P.pink, italic = true })   -- storage.type
        hl(" @keyword.return",          { fg = P.pink, italic = true })
        hl(" @attribute",               { fg = P.cyan, italic = true })   -- html attrs
        -- Exclusões de itálico
        hl(" @operator",                { fg = P.pink, italic = false })
        hl(" @number",                  { fg = P.yel,  italic = false })
        hl(" @float",                   { fg = P.yel,  italic = false })

        -- Grupos semânticos
        hl(" @string",                  { fg = P.grn })
        hl(" @string.escape",           { fg = P.yel, bold = true })
        hl(" @function",                { fg = P.cyan })
        hl(" @function.call",           { fg = P.cyan })
        hl(" @method",                  { fg = P.cyan })
        hl(" @constructor",             { fg = P.cyan })
        -- Negrito para "class names"
        hl(" @type",                    { fg = P.yel, bold = true, italic = true })
        hl(" @type.definition",         { fg = P.yel, bold = true, italic = true })
        hl(" @type.builtin",            { fg = P.yel, bold = true })
        hl(" @namespace",               { fg = P.yel, italic = true })
        hl(" @variable",                { fg = P.text })
        hl(" @property",                { fg = P.grn })
        hl(" @parameter",               { fg = P.yel, italic = true })

        -- LSP semantic tokens (Java/Go/TS/C)
        hl(" @lsp.type.class",          { fg = P.yel, bold = true, italic = true })
        hl(" @lsp.type.interface",      { fg = P.yel, italic = true })
        hl(" @lsp.type.enum",           { fg = P.yel, italic = true })
        hl(" @lsp.type.namespace",      { fg = P.yel, italic = true })
        hl(" @lsp.type.parameter",      { fg = P.yel, italic = true })
        hl(" @lsp.type.property",       { fg = P.grn })
        hl(" @lsp.type.method",         { fg = P.cyan })
        hl(" @lsp.type.function",       { fg = P.cyan })
        hl(" @lsp.type.variable",       { fg = P.text })

        -- Diagnostics
        hl("DiagnosticError", { fg = P.red })
        hl("DiagnosticWarn",  { fg = P.yel })
        hl("DiagnosticInfo",  { fg = P.cyan })
        hl("DiagnosticHint",  { fg = P.purp })

        -- Markdown headings: negrito + itálico
        hl(" @markup.heading", { fg = P.cyan, bold = true, italic = true })

        -- Telescope
        hl("TelescopeBorder",       { fg = P.purp, bg = "NONE" })
        hl("TelescopePromptBorder", { fg = P.pink, bg = "NONE" })
        hl("TelescopeSelection",    { bg = P.blue, fg = P.bg, bold = true })
        hl("TelescopeMatching",     { fg = P.grn, bold = true })

        -- Git
        hl("GitSignsAdd",    { fg = P.grn })
        hl("GitSignsChange", { fg = P.yel })
        hl("GitSignsDelete", { fg = P.red })

        -- Terminal palette
        vim.g.terminal_color_0  = P.bg
        vim.g.terminal_color_1  = P.pink
        vim.g.terminal_color_2  = P.grn
        vim.g.terminal_color_3  = P.yel
        vim.g.terminal_color_4  = P.cyan
        vim.g.terminal_color_5  = P.mag
        vim.g.terminal_color_6  = P.purp
        vim.g.terminal_color_7  = P.text
        vim.g.terminal_color_8  = P.dim
        vim.g.terminal_color_9  = P.pink
        vim.g.terminal_color_10 = P.grn
        vim.g.terminal_color_11 = P.yel
        vim.g.terminal_color_12 = P.blue
        vim.g.terminal_color_13 = P.mag
        vim.g.terminal_color_14 = P.purp
        vim.g.terminal_color_15 = "#FFFFFF"
      end

      local function set_theme(theme)
        theme = theme or (vim.g.neosairu_theme or "cyberdream")
        vim.schedule(function()
          pcall(vim.cmd.colorscheme, theme)
          apply_core()
        end)
      end

      local function set_transparent(mode)
        if mode == "toggle" then state.transparent = not state.transparent
        else state.transparent = not not mode end
        apply_core()
      end

      local function set_boost(level)
        state.boost = math.max(0, math.min(2, tonumber(level) or 1))
        apply_core()
      end

      -- Comandos de usuário
      vim.api.nvim_create_user_command("NeoTheme", function(o) set_theme(o.args ~= "" and o.args or nil) end, { nargs = "?" })
      vim.api.nvim_create_user_command("NeoTransparent", function(o)
        local arg = o.args
        if arg == "on" then set_transparent(true)
        elseif arg == "off" then set_transparent(false)
        else set_transparent("toggle") end
      end, { nargs = "?" })
      vim.api.nvim_create_user_command("NeoBoost", function(o) set_boost(o.args) end, { nargs = "?" })

      -- Reaplicar overrides ao trocar de esquema
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("neosairu_colors", { clear = true }),
        callback = function() apply_core() end,
      })

      -- Aplicar inicial
      set_theme(vim.g.neosairu_theme or "cyberdream")
      set_transparent(true)
    end,
  },

  -- Noirbuddy como perfil alternativo de alta legibilidade
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    lazy = true,
    opts = {
      use_background = false, -- favorece contraste com transparência
    },
    config = function(_, opts)
      local ok, noir = pcall(require, "noirbuddy")
      if not ok then return end
      noir.setup(opts or {})
      -- reaproveita os mesmos overrides para manter tipografia
      vim.schedule(function() vim.cmd.colorscheme("noirbuddy") end)
    end,
  },

  -- Opcional: cyberdream puro, caso queira alternar
  {
    "scottmckendry/cyberdream.nvim",
    name = "cyberdream",
    lazy = true,
    opts = { transparent = true, italic_comments = true, borderless_telescope = true },
  },

  -- Helper para alternar esquema base sem perder overrides
  {
    "folke/which-key.nvim",
    optional = true,
    config = function()
      vim.api.nvim_create_user_command("NeoBase", function(o)
        local theme = o.args
        if theme == "noir" or theme == "noirbuddy" then
          pcall(vim.cmd.colorscheme, "noirbuddy")
        elseif theme == "cyber" or theme == "cyberdream" then
          pcall(function()
            require("cyberdream").setup({ transparent = true, italic_comments = true, borderless_telescope = true })
          end)
          pcall(vim.cmd.colorscheme, "cyberdream")
        else
          -- volta para gruvbox-material como base
          vim.o.background = "dark"
          vim.g.gruvbox_material_background = "hard"
          vim.g.gruvbox_material_transparent_background = 2
          vim.g.gruvbox_material_enable_bold = 1
          vim.g.gruvbox_material_enable_italic = 1
          pcall(vim.cmd.colorscheme, "gruvbox-material")
        end
        -- triggers: nosso autocmd "ColorScheme" reaplica os overrides
      end, { nargs = "?", complete = function() return { "gruvbox", "noir", "cyber" } end })
    end,
  },
}