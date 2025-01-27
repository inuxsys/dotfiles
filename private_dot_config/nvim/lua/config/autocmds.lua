-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local autocmd = vim.api.nvim_create_autocmd
local Format = vim.api.nvim_create_augroup("Format", { clear = true })
autocmd("BufWritePre", {
  group = Format,
  pattern = "*.ts,*.tsx,*.jsx,*.js",
  callback = function(args)
    local tstools = require("typescript-tools.api")
    tstools.add_missing_imports(true)
    tstools.organize_imports(true)
    tstools.fix_all(true)
    require("conform").format({ bufnr = args.buf })
  end,
})
