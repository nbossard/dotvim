-- Nicolas Bossard, 1st november 2023, personal syntax for NEOVIM editor
-- Saved in git for history and for sharing across computers.
-- As described here :
-- See README.md for configuration.
-- vim: set foldmethod=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab:
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

-- Allowing per project configuration
-- For example to have a custom spellfile
-- See https://andrew.stwrt.ca/posts/project-specific-vimrc/
vim.opt.exrc = true
vim.opt.secure = true


--
-- ---------------------- PACKAGE MANAGER CONFIG -----------------------

-- {{{ lazy : plugin manager
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
--- }}}

-- {{{ nvim-tree : file tree manager
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
      -- Define the alias for previous plugin Nerdtree
      vim.cmd('command! -nargs=0 NERDTree NvimTreeOpen')
    end,
  }
end
--- }}}

-- {{{ gitsigns : to display a git column markers
-- close to line numbers
-- see : https://github.com/lewis6991/gitsigns.nvim
-- Replacing GitGutter
function plug_gitsigns()
   return {
    "lewis6991/gitsigns.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("gitsigns").setup {}
    end,
  }
end
--- }}}

-- {{{ lualine : to display a bottom status bar
-- see : https://github.com/nvim-lualine/lualine.nvim
-- replacing airline
function plug_lualine()
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('lualine').setup()
  end
}
end
--- }}}

-- {{{ startup.nvim: The fully customizable greeter for neovim
-- replacing startify
-- See hhttps://github.com/startup-nvim/startup.nvim
function  plug_startup()
  return {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
      require"startup".setup()
    end
  }
end
-- }}}

-- {{{ telescope : A highly extendable fuzzy finder over lists
-- Replacing CtrlP and fzf : fuzzy finder inside vim
-- used to search files and live ripgrep
function plug_telescope()
  return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- alias ":rg" to ":Telescope live_grep"
      vim.cmd('command! -nargs=0 Rg Telescope live_grep')
      vim.cmd('abbreviate rg Rg')
    end
  }
end
-- }}}

-- {{{ Adding plugin to highlight trailing whitespace
-- https://github.com/ntpeters/vim-better-whitespace
-- To launch manual stripping of whitespaces :
-- :StripWhitespace
function plug_trailing_whitespaces()
  return {
    "ntpeters/vim-better-whitespace",
    version = "*",
    lazy = false,
    config = function()
      vim.g.better_whitespace_filetypes_blacklist={'diff', 'gitcommit', 'unite', 'qf', 'help', 'mail', 'startify', 'git', 'taskedit', 'csv', 'minimap'}
      -- To highlight space characters that appear before or in-between tabs
      vim.g.show_spaces_that_precede_tabs=1
      -- To enable highlighting of trailing whitespace
      vim.g.better_whitespace_enabled=1
      -- Enabling stripping on save (with confirmation)
      vim.g.strip_whitespace_on_save=1
      vim.g.startify_change_to_dir=0
      --  Note that overwriting this with a b: is ignored
      vim.g.strip_whitespace_confirm=0
    end,
  }
end
-- }}}

-- {{{ tcomment_vim : Quick comment uncomment
-- see https://github.com/tomtom/tcomment_vim
-- Usage : gc<motion>
-- gcc for current line
function plug_tcomment()
  return {
    'tomtom/tcomment_vim'
  }
end
 -- }}}

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

-- {{ Plugin to support Go Language
-- https://github.com/ray-x/go.nvim
-- Replaces fatih/vim-go written in vimscript mostly
function plug_x_go()
  return
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
end


-- }}}


-- {{{ ===== Various colorscheme s ====

function plug_color_scheme_gruvbox()
  return {
    'morhetz/gruvbox',
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end
  }
end

-- usedd by documentation repository
function plug_color_scheme_dracula()
  return {
    'dracula/vim',
  }
end

-- }}}

require("lazy").setup({
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  'github/copilot.vim',
  'nvim-lspconfig',
  plug_nvim_tree(),
  plug_lualine(),
  plug_gitsigns(),
  plug_startup(),
  plug_trailing_whitespaces(),
  plug_vim_taskwarrior_conf(),
  plug_tcomment(),
  plug_x_go(),
  plug_telescope(),
  plug_color_scheme_gruvbox(),
  plug_color_scheme_dracula(),
})

