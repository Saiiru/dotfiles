-- lua/grimmvim/config/options.lua
local opt = vim.opt

-- Globais/Janela (seguras na init)
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.clipboard = "unnamedplus"

-- Defaults de indentação (globais)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Remover auto-comentário padrão
opt.formatoptions = opt.formatoptions - "c" - "r" - "o"

-- Aplique buffer-locais só em arquivos “normais”
local aug = vim.api.nvim_create_augroup("kora_bufopts", { clear = true })
local function is_normal(buf)
  return vim.bo[buf].buftype == "" and vim.bo[buf].buflisted
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
  group = aug,
  callback = function(ev)
    if not is_normal(ev.buf) then return end
    vim.bo[ev.buf].expandtab = true
    vim.bo[ev.buf].shiftwidth = 2
    vim.bo[ev.buf].tabstop = 2
    vim.bo[ev.buf].softtabstop = 2
  end,
})