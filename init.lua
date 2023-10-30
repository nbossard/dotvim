-- Nicolas Bossard, 28Th may 2018, personal syntax for VIM editor
-- Saved in git for history and for sharing across computers.
-- As described here :
-- See README.md for configuration.
-- vim: set foldmethod=marker :
--
-- Other installs :
-- brew install python@2
-- brew install python3
-- pip2 install neovim --upgrade
-- pip3 install neovim --upgrade
--
-- then test config with (neovim only):
-- :checkhealth
--
vim.g.python_host_prog='/usr/local/bin/python'
vim.g.python3_host_prog='/usr/local/bin/python3'

-- define the <leader> key
vim.g.mapleader=","

-- display line numbers
vim.wo.number=true

--
-- ---------------------- PACKAGE MANAGER CONFIG -----------------------
-- lazy replaces vim-plug
-- vim-plug replaces Vundle

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Installing nvim-tree to replace nerdtree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
 vim.opt.termguicolors = true
function plug_nvim_tree() 
  return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  } 
end

function plug_gitsigns()
   return {
    "lewis6991/gitsigns.nvim",
    version = "*",
    lazy = false,
  }
end

-- {{{ ==== Languages syntax support plugins ======

-- {{{ Plugin to support syntax for taskwarrior config files
-- Plug 'nbossard/vim-taskwarrior-conf', {'for': 'taskrc'}
function plug_vim_taskwarrior_conf()
  return {
    "nbossard/vim-taskwarrior-conf",
    version = "*",
    lazy = true,
  }
end
-- }}}

-- }}}

require("lazy").setup({
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  plug_nvim_tree(),
  plug_gitsigns(),
  plug_vim_taskwarrior_conf(),
})

