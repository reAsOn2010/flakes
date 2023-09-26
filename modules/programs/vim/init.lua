-- some my config
vim.opt.syntax="on"
vim.opt.clipboard:append('unnamedplus')
-- vim.api.nvim_create_user_command('T', function()
-- pcall(function()
--     vim.fn.Preserve("belowright split | resize 8 | terminal")
--   end)
-- end,{})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


