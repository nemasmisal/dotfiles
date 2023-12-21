require("config.keymaps")

local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end
})

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local ok, lazy_module = pcall(require, "lazy")

if not ok then
  print("Lazy module could not be loaded")
else
  lazy_module.setup("plugins")
end
