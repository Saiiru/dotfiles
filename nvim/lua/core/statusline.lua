----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

-- Plugin: feline.nvim
-- url: https://github.com/feline-nvim/feline.nvim

-- For the configuration see the Usage section:
-- https://github.com/feline-nvim/feline.nvim/blob/master/USAGE.md

-- Thanks to ibhagwan for the example to follow:
-- https://github.com/ibhagwan/nvim-lua

local status_ok, statusline = pcall(require, 'statusline')
if not status_ok then
  return
end
statusline.tabline = false
