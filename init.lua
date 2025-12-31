-- Nicolas Bossard, 1st november 2023, personal syntax for NEOVIM editor
-- Saved in git for history and for sharing across computers.
-- As described here :
-- See README.md for configuration.
-- vim: set foldmethod=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab:
--
-- then test config with (neovim only):
-- :checkhealth
-- then :checkhealth python3

vim.g.python_host_prog='/usr/local/bin/python'
vim.g.python3_host_prog='/opt/homebrew/bin/python3'

-- define the <leader> key
vim.g.mapleader=","
-- define the <leader> key
vim.g.maplocalleader=","

-- display line numbers
vim.wo.number=true

-- Allowing per project configuration
-- For example to have a custom spellfile
-- See https://andrew.stwrt.ca/posts/project-specific-vimrc/
vim.opt.exrc = true
vim.opt.secure = true
-- allow Vim to read and interpret these modelines when opening files.
vim.opt.modeline = true
-- how many lines from the top and bottom of the file will be checked for modelines.
vim.opt.modelines = 5
--
-- ---------------------- PACKAGE MANAGER CONFIG -----------------------

-- {{{ lazy : plugin manager
-- lazy replaces vim-plug
-- vim-plug replaces Vundle
-- following line is evaluated to ~/.local/share/nvim/lazy/lazy.nvim
-- (:echo luaeval('vim.fn.stdpath("data")'))
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

-- lazy configuration options for loading spec
-- event = "VimEnter" -- lazy load when vim starts
-- event = "VeryLazy" -- lazy load when a plugin is used
-- event = "BufEnter" : lazy load when a buffer is opened
-- event = "CmdlineEnter" : lazy load when a command is run
-- ft = "typescript",
-- cmd = {"ALEFix", "ALEInfo"},

-- {{{ copilot-lua plugin for github copilot
-- replacing official'github/copilot.vim',
-- see : https://github.com/zbirenbaum/copilot.lua
local function plug_copilot()
  return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  filetypes = {
    yaml = false,
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    sh = true
  },
  copilot_model = "Claude Sonnet 4.5",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          -- keymap to accept the suggestion
          accept = "<M-a>",
          -- keymap to accept the word
          accept_word = "<M-w>",
          -- keymap to accept the line
          accept_line = "<M-l>",
        }
      }
    })
  end,
  }
end
--- }}}

-- {{{ TabbyML plugin
-- see : https://tabby.tabbyml.com/docs/extensions/installation/vim/
-- done : npm install --global tabby-agent
--
-- usage :
--   can be called via language server (see COQ)
--   or can be called manually (see keymaps below) IN INSERT MODE
--
-- monitoring or debugging :
--    http://0.0.0.0:8080/
-- local function plug_tabby()
--   return {
--     "TabbyML/vim-tabby",
--     dependencies = {}, -- do not add nvim-lspconfig here, useless in O.11
--     init = function()
--       vim.g.tabby_agent_start_command = {"npx", "tabby-agent", "--stdio"}
--       vim.g.tabby_inline_completion_trigger = "auto"
--     end,
--     config = function()
--       -- manual or auto mode
--       -- :lua print(vim.g.tabby_inline_completion_trigger)
--       vim.g.tabby_inline_completion_trigger = 'manual' --default is 'auto'
--       -- can be found here : http://localhost:8080/
--       -- or here :
--       vim.g.tabby_token= 'auth_9a8a149b6a634cb79a31268110d48eac'
--       -- keymaps
--       vim.g.tabby_inline_completion_keybinding_trigger_or_dismiss = '<M-l>' -- default is <tab>
--       vim.g.tabby_inline_completion_keybinding_accept = '<M-m>' -- default is <C-\>
--     end,
--   }
-- end
--- }}}

-- {{{ start screen plugin
-- tried alpha-nvim and startup.nvim but both are too complex to configure
local function plug_start_screen()
-- see also TODO startup.nvim
  -- {
  --   'goolord/alpha-nvim',
  --   config= function ()
  --     local startify = require("alpha.themes.startify")
  --     -- available: devicons, mini, default is mini
  --     -- if provider not loaded and enabled is true, it will try to use another provider
  --     startify.file_icons.provider = "devicons"
  --     -- add find files
  --     startify.section.buttons.val = vim.list_extend(
  --       startify.section.buttons.val,
  --       {
  --         startify.button("f", "  Find File", ":Telescope find_files <CR>"),
  --       }
  --     )
  --
  --     require("alpha").setup(
  --       startify.config
  --     )
  --   end
  -- },
  -- {
  --   "startup-nvim/startup.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
  --   config = function()
  --     require("startup").setup({theme = "startify"})
  --   end
  -- },
  return {
    'nvim-mini/mini.starter',
    version = '*',
    config = function()
      require('mini.starter').setup()
    end
  }
end
--- }}}

-- {{{ which-key : plugin to display key mapping
-- see : https://github.com/folke/which-key.nvim
local function plug_which_key()
  return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
end

-- library mini icons
-- is suggested to be installed by which-key in its checkhealth screen
local function plug_mini_icons()
  return {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    version = false
  }
end
--- }}}

-- {{{ LSP configuration
-- https://github.com/neovim/nvim-lspconfig
--
-- *grr* *gra* *grn* *gri* *grt* *i_CTRL-S*
-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- - "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
-- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
-- See : LspInfo

-- NBO: 2025-01-31 Removed nvim-lspconfig plugin - not needed in Neovim 0.11+
-- Neovim 0.11+ has built-in LSP configuration via vim.lsp.config() and vim.lsp.enable()
-- Keeping the LSP configuration but moving it to a direct setup
local function setup_lsp_servers()
  -- Set autostart = false for all servers (we'll enable them explicitly)
  vim.lsp.config('*', {
    autostart = false
  })

  -- warning : debug level is very verbose
  vim.lsp.set_log_level("WARN")

      -- For HTML
      -- See doc here
      -- npm install -g vscode-langservers-extracted
      vim.lsp.enable('html')

      -- For CSS
      -- npm install -g css-variables-language-server
      vim.lsp.enable('css_variables')

      -- For JavaScript and TypeScript
      -- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tsserver
      -- npm install -g typescript typescript-language-server
      -- NOTE : the setup lsp_ensure_capabilities is to support COQ snippets
      vim.lsp.config('ts_ls',{
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
        -- inlay hints configuration as suggested by
        -- https://github.com/MysticalDevil/inlay-hints.nvim
        -- configured below
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },

        filetypes = {
          "javascript",
          "typescript",
          "vue",
          "typescriptreact"
        }
      })
      vim.lsp.enable('ts_ls')

      -- For Makefile
      -- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#autotools_ls
      -- install : pipx install autotools-language-server
      vim.lsp.enable('autotools_ls')

      -- For Angular
      -- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#angularls
      -- npm install -g @angular/language-server
      -- require'lspconfig'.angularls.setup{}

      -- For bash
      -- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
      -- npm install -g bash-language-server
      vim.lsp.enable('bashls')

      -- For Java
      -- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#java_language_server
      vim.lsp.config('java_language_server',{
        cmd = {'jdtls'},
        -- do not set filetype painless : it is too different from java
        filetypes = {
          "java"
        }
      })


      -- For Golang
      -- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gopls
      -- and here : https://github.com/golang/tools/tree/master/gopls
      -- install :
      -- go install golang.org/x/tools/gopls@latest
      vim.lsp.config('gopls',{
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      vim.lsp.enable('gopls')

      -- For JSON
      -- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
      -- npm install -g vscode-langservers-extracted
      vim.lsp.enable('jsonls')

      -- For Python
      -- several lsp :
      --   pylyzer, written in rust : https://github.com/mtshiba/pylyzer.
      --   testé mais sort pleins d'erreurs et consomme 300% de CPU en permanence
      -- trying another one
      -- https://github.com/python-lsp/python-lsp-server
      -- installed via homebrew
      vim.lsp.enable('pylsp')

      -- For Cucumber
      -- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cucumber_language_server
      -- tried it but complains a lot about undefined steps, disabled
      -- require 'lspconfig'.cucumber_language_server.setup{}

      -- For Lua
      -- Install server using `brew install lua-language-server`
      -- See setup config here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
      vim.lsp.config('lua_ls',{
        cmd = { 'lua-language-server' },  -- Explicitly set the command
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            },
            runtime = {
              version = 'LuaJIT',
            }
          }
        }
      })
      vim.lsp.enable('lua_ls')


      -- For yaml
      -- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
      -- or npm install -g yaml-language-server
      vim.lsp.enable('yamlls')

      -- For Markdown
      -- Using Marksman LSP
      -- see : https://github.com/artempyanykh/marksman
      vim.lsp.enable('marksman')
end

-- Call the LSP setup function
setup_lsp_servers()
--- }}}

-- {{{ plugin to ease config process of display LSP inlay hints
-- see : https://github.com/MysticalDevil/inlay-hints.nvim
-- See also configuration in LSP config above
local function plug_lsp_inlay_hints()
  return {
    'MysticalDevil/inlay-hints.nvim',
    event = "LspAttach",
    dependencies = {}, -- DO NOT add nvim-lspconfig here, useless in O.11
    config= function ()
      require("inlay-hints").setup(
        {
          commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
          autocmd = { enable = true } -- Enable the inlay hints on `LspAttach` event
        })
    end
  }
end
-- }}}

-- {{{ marks
-- display marks in gutter
-- see : https://github.com/chentoast/marks.nvim
-- reminder :
-- < == special mark, beginning of last visual selection
-- > == special mark, end of last visual selection
local function plug_mark()
  return {
    'chentoast/marks.nvim', -- display marks
    event = "VeryLazy",
    config = function()
      require("marks").setup({
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
      })
    end
  }
end
-- }}}

-- {{{ ALE : Asynchronous Lint Engine
-- Linter.
-- see : https://github.com/dense-analysis/ale
-- Usage : :ALEFix to make Prettier fix the file
--   see g:ale_fixers below
local function plug_ale()
  -- define a new alias ":Prettier" as an alias to ALEFix
  vim.cmd('command! -nargs=0 Prettier echo "Use :ALEFix"')

  return {
    "dense-analysis/ale",
    ft = "typescript,typescriptreact,json,yaml,markdown,css,scss,html,vue,go,make,javascript,sh",
    cmd = {"ALEFix", "ALEInfo"},
    config = function()

      vim.g.ale_linters = {
        -- golangci-lint calls numerous linters in the background
        -- requires a project local config file
        go=   {'gobuild', 'golint', 'go vet', 'golangci-lint', 'staticcheck'},
        yaml= {'yamllint', 'spectral'},
        javascript = {'eslint'},
        typescript = {'eslint', 'aichatnicolinter'},
        typescriptreact = {'eslint'},
        markdown = {'aichatnicolinter'},
        sh = {'shellcheck'},
        make = {'mbake'},
        lua = {} -- explicitly disable to prevent ALE from starting another instance of lua-language-server
      }

      vim.g.ale_fixers = {
        typescript = {'prettier'},
        javascript = {'prettier'},
        json = {'prettier'},
        jsonc = {'prettier'},
        yaml = {'prettier'},
        markdown = {'prettier'},
        css = {'prettier'},
        scss = {'prettier'},
        html = {'prettier'},
        vue = {'prettier'},
        typescriptreact = {'prettier'},
        make = {'mbakefmt'}
      }
      -- key mapping to Fix the file
      -- document this key mapping for which-key
      local wk = require("which-key")
      wk.add({ { "<leader>x", "<cmd>ALEFix<cr>", desc = "ALE Fix" }, })
    end,
  }
end
-- }}}

-- {{{ vim ghost : to use vim to edit firefox fields
-- NBO : something strange with ghost, seems always loaded, strange strange
local function plug_vimghost()
  return {
    -- OLD "raghur/vim-ghost", changed on 2024-12-16 to :
    "subnut/nvim-ghost.nvim"
    -- cmd = {
    --   "GhostInstall",
    --   "GhostStart"
    -- }
  }
end
-- }}}

-- {{{ Treesitter : syntax highlighter
-- see : https://github.com/nvim-treesitter/nvim-treesitter
-- Usage : TSInstallInfo
-- Usage : TSInstall <language>
-- Puis : TSEnable
-- :TSUpdate all
local function plug_treesitter()
  return {
    "nvim-treesitter/nvim-treesitter",
    version = "*", -- * means lazy should install any OFFICIAL version
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "lua", "go" , "java", "bash", "html", "css", "javascript", "typescript", "jsdoc", "markdown", "json", "jsonc", "yaml"},
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `treesitter` CLI installed locally
        auto_install = false,
        -- List of parsers to ignore installing (or "all")
        ignore_install = {
          "make" -- NBO : 2024-08-16 not convinced with treesitter coloring of makefiles, less good than standard
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,
        highlight = {
          enable = true,
          -- list of language that will be disabled
          disable = { "query" },
        },
        indent = {
          enable = false
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>", -- set to `false` to disable one of the mappings
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        modules ={}
      }

      -- treesitter breaks foldmethod=syntax when enabled for a filetype
      -- but works if setting it to expr
      vim.cmd("autocmd Filetype go setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype go setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for lua
      vim.cmd("autocmd Filetype lua setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype lua setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for markdown
      vim.cmd("autocmd Filetype markdown setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype markdown setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for javascript
      vim.cmd("autocmd Filetype javascript setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype javascript setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for javascript
      vim.cmd("autocmd Filetype typescript setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype typescript setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for json
      vim.cmd("autocmd Filetype json setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype json setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for jsonc
      vim.cmd("autocmd Filetype jsonc setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype jsonc setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for html
      vim.cmd("autocmd Filetype html setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype html setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for yaml
      vim.cmd("autocmd Filetype yaml setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype yaml setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for makefile
      vim.cmd("autocmd Filetype make setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype make setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for bash
      vim.cmd("autocmd Filetype bash setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype bash setlocal foldexpr=nvim_treesitter#foldexpr()")
      -- same for sh
      vim.cmd("autocmd Filetype sh setlocal foldmethod=expr")
      vim.cmd("autocmd Filetype sh setlocal foldexpr=nvim_treesitter#foldexpr()")

      vim.cmd("autocmd Filetype json setlocal foldmethod=syntax")

    end
  }
end
--}}}

-- {{{ treesitter context: plugin to keep function name line on top
-- see https://github.com/nvim-treesitter/nvim-treesitter-context
local function plug_treesitter_context()
  return {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    config = function()
      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = '―',
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end
  }
end
-- }}}

-- {{{ treesj: plugin to split or join lines of code with intelligence
-- see : https://github.com/Wansmer/treesj
local function plug_treesj()
  return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      local wk = require("which-key")
      -- add key map for split/join
      wk.add({
        { "<leader>s", group = "treeSJ (split/join)" },
        { "<leader>sj", "<cmd>TSJJoin<cr>", desc = "Treesj Join" },
        { "<leader>ss", "<cmd>TSJSplit<cr>", desc = "Treesj Split" },
      })

      require('treesj').setup({
        use_default_keymaps = false,
      })
      -- which key definition is done much below because
      -- if done here plug is not loaded so no tooltip
      -- if just here below, which-key is not loaded yet
    end
  }
end
-- }}}

-- {{{ nvim-tree : file tree manager
--
-- Installing nvim-tree to replace nerdtree
-- see : https://github.com/nvim-tree/nvim-tree.lua
-- Help window : "g?"
--
-- If folders like node_modules are not displayed,
-- may be they are filtered by automatic filtering
-- based on .gitignore file content.
-- Try pressing "I" to toggle the display of GIT ignored files.
--
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- function to open the file tree at start
-- later when all plugins are started
-- see https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
-- rem : do not lazy load nvim-tree
local function open_nvim_tree()
  -- open the tree
  if not vim.g.started_by_firenvim then
    require("nvim-tree.api").tree.open()
    -- do not leave focus on tree
    vim.cmd(":wincmd w")
  end
end
-- config function to setup nvim-tree
local function plug_nvim_tree()
  return {
    "nvim-tree/nvim-tree.lua",
    version = "*", -- * means any OFFICIAL version
    dependencies = {
      -- optional used to show icons in the tree
      -- see https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        -- Changes the tree root directory on DirChanged and refreshes the three.
        sync_root_with_cwd = true,
        -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
        respect_buf_cwd = true,
        -- update the focused file on BufEnter, up-collapses the folders recursively until if finds the file.
        update_focused_file = {
          enable = true,
          -- Update the root directory of the tree if the file is not under current root directory.
          update_root = {
            enable = true,
          }
        },
      }
      -- Define the alias for previous plugin Nerdtree
      vim.cmd('command! -nargs=0 NERDTree echo "Use :NvimTreeOpen"')
      -- faster open alias
      vim.cmd('command! -nargs=0 NVO :NvimTreeOpen')


      -- key mapping to open current file in nvim-tree
      -- document this key mapping for which-key
      local wk = require("which-key")
      wk.add({{ "gnF", "<cmd>NvimTreeFindFile<cr>", desc = "Locate current file in nvim-tree" },})

      -- launch at start
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  }
end

-- configure neovim to open image in an external editor
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd("silent !open " .. filename .. " &")
    vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
  end
})
--- }}}

-- {{{ gitsigns : to display a git column markers in the gutter
-- close to line numbers
-- see : https://github.com/lewis6991/gitsigns.nvim
-- Usage : :Gitsigns
-- Replacing GitGutter
--
-- Compare current file with another version in git
--    :Gitsigns diffthis main
-- show line commit
--    :Gitsigns blame
--    :Gitsigns blame_line
--    :Gitsigns toggle_current_line_blame
--
local function plug_gitsigns()
   return {
    "lewis6991/gitsigns.nvim",
    version = "*", -- * means any OFFICIAL version
    lazy = false,
    config = function()
      require("gitsigns").setup {
        -- requires activation using :Gitsigns toggle_current_line_blame
        -- also try
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      }
      local wk = require("which-key")
      -- add key map for go to next/previous hunk
      wk.add({
        { "gh", group = "Git Hunk" },
        { "ghb", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame line" },
        { "ghn", "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next hunk" },
        { "ghp", "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous hunk" },
      })
      -- add other key maps
      wk.add({
        { "<leader>h", group = "Git Hunk" },
        { "<leader>hd", "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Diff this" },
        { "<leader>hp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview hunk" },
        { "<leader>hr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset hunk" },
        { "<leader>hs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage hunk" },
      })
    end,
  }
end
--- }}}

-- {{{ lazyjui : plugin to display a UI for lazy.nvim
-- see : https://github.com/mrdwarf7/lazyjui.nvim
local function plug_lazyjui()
  return {
    "mrdwarf7/lazyjui.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<leader>j", "", desc = "LazyJui" },
      { "<leader>jj", ":LazyJui<CR>", desc = "Launch LazyJui" },
    },
    opts =  {
      -- Will default to just `jjui`
      cmd = { "jjui", "-r", "all()" },
    }
  }
end
--- }}}

-- {{{ lualine : to display a bottom status bar
-- see : https://github.com/nvim-lualine/lualine.nvim
-- replacing airline
local function plug_lualine()
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('lualine').setup({
      options = {
        -- Disable lualine for specific filetypes
        disabled_filetypes = {
          'Avante',
          'AvanteSelectedFiles',
          'AvanteInput',
          'NvimTree'
        }
      }
    })
  end
}
end
--- }}}

-- {{{ telescope : A highly extendable fuzzy finder over lists
-- https://github.com/nvim-telescope/telescope.nvim
-- Replacing CtrlP and fzf : fuzzy finder inside vim
-- used to search files and live ripgrep
local function plug_telescope()
  return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim', -- All the lua functions I don't want to write twice.
      'debugloop/telescope-undo.nvim', -- an undo tree : `Telescope undo`
    },
    config = function()
      -- adding alias for telescope live_grep with optional parameter in command line
      vim.api.nvim_create_user_command(
      'Rg',
      function(opts)
        local search = opts.args or "" -- This ensures that opts.args is set to an empty string if no argument is provided
        require('telescope.builtin').live_grep({ default_text = search })
      end,
      { nargs = '?' }  -- '?' allows zero or one argument
      )
      require("telescope").load_extension("undo")
      vim.cmd('abbreviate rg Rg')
      -- adding alias used when using plugin bufexplore
      -- <leader>be to open buffers
      -- OLD STYLE replaced by which key register : vim.keymap.set('n','<leader>be', ':Telescope buffers<CR>')
      local wk = require("which-key")
      wk.add({
        { "<leader>b", group = "buffer" },
        { "<leader>be", "<cmd>Telescope buffers<cr>", desc = "Show buffers list" },
        { "<leader>f", group = "file" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

        { "<leader>t", group = "telescope" },
        { "<leader>tr", "<cmd>Telescope lsp_references<cr>", desc = "LSP Goto References" },
      })

    end
  }
end
-- }}}

-- {{{ grug-far : plugin to use ripgrep multiline search
-- https://github.com/MagicDuck/grug-far.nvim
-- useful text for search, relying on ripgrep
-- allows multiline search
-- Usage : select text in visual mode and type :'<,'>Rgm
local function plug_ripgrep_multiline()
  return {
    'MagicDuck/grug-far.nvim',
    event = "VeryLazy",
    config = function()
      -- Add this to your init.lua or a configuration file that gets loaded
      vim.api.nvim_create_user_command('Rgm', function(opts)
        local range = ''
        if opts.range == 2 then
          range = opts.line1 .. ',' .. opts.line2
        end

        vim.cmd(range .. 'GrugFar')
      end, {
      range = true,
      desc = 'Alias for GrugFar command'
    })
  end
}
end
-- }}}

-- {{{ vista : plugin to display tags or lsp info about methods, const, properties.. in a side window
-- see : https://github.com/liuchengxu/vista.vim
local function plug_vista()
  return {
    'liuchengxu/vista.vim',
    cmd = {'Vista'},
    config = function()
      -- special executive for some filetypes
      vim.g.vista_executive_for = {
        -- use treesitter for go files
        javascript = 'nvim_lsp'
      }
      -- sort methods by order of appearance
      --
      -- enable icons
      -- let g:vista#renderer#enable_icon = 1
      vim.cmd('let g:vista#renderer#enable_icon = 1')
    end
  }
end
-- }}}

-- {{{ Plugin to use ripgrep  inside vim
-- https://github.com/mangelozzi/rgflow.nvim
local function plug_rgflow()
  return {
    "mangelozzi/rgflow.nvim",
    event = "CmdlineEnter",
    config = function()
        require('rgflow').setup(
        {
            -- Set the default rip grep flags and options for when running a search via
            -- RgFlow. Once changed via the UI, the previous search flags are used for
            -- each subsequent search (until Neovim restarts).
            cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",
            -- Mappings to trigger RgFlow functions
            default_trigger_mappings = true,
            -- These mappings are only active when the RgFlow UI (panel) is open
            default_ui_mappings = true,
            -- QuickFix window only mapping
            default_quickfix_mappings = true,
        })
            --            -- Normal mode maps
            -- n = {
            --     ["<leader>rG"] = "open_blank", -- open UI - search pattern = blank
            --     ["<leader>rg"] = "open_cword", -- open UI - search pattern = <cword>
            --     ["<leader>rp"] = "open_paste", -- open UI - search pattern = First line of unnamed register as the search pattern
            --     ["<leader>ra"] = "open_again", -- open UI - search pattern = Previous search pattern
            --     ["<leader>rx"] = "abort",      -- close UI / abort searching / abortadding results
            --     ["<leader>rc"] = "print_cmd",  -- Print a version of last run rip grep that can be pasted into a shell
            --     ["<leader>r?"] = "print_status",  -- Print info about the current state of rgflow (mostly useful for deving on rgflow)
            -- },
        local wk = require("which-key")

        wk.add({
          { "<leader>r", group = "rgflow" },
          { "<leader>rG", ":lua require('rgflow').open_cword()<cr>", desc = "open UI - search pattern = <cword>" },
          { "<leader>ra", ":lua require('rgflow').open_again()<cr>", desc = "open UI - search pattern = Previous search pattern" },
          { "<leader>rc", ":lua require('rgflow').print_cmd()<cr>", desc = "Print last run for paste shell" },
          { "<leader>rg", ":lua require('rgflow').open_blank()<cr>", desc = "open UI - search pattern = blank" },
          { "<leader>rr", ":lua require('rgflow').open_blank()<cr>", desc = "open UI - search pattern = blank" },
          { "<leader>rp", ":lua require('rgflow').open_paste()<cr>", desc = "open UI - search pattern = First line of unnamed register as the search pattern" },
        })
    end,
  }
end
-- }}}

-- {{{ jsonpath : display current cursor jsonpath in winbar.
-- see : https://github.com/phelipetls/jsonpath.nvim
-- to copy path <leader>p
local function plug_jsonpath()
  return {
    "phelipetls/jsonpath.nvim",
    ft = {"json", "jsonc", "hjson"},
    config = function ()
      if vim.fn.exists("+winbar") == 1 then
        -- displays info in winbar
        vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
        -- send json path to clipboard
      end
      vim.keymap.set({'n'}, '<leader>p', function()
        vim.fn.setreg("+", require("jsonpath").get())
      end, { desc = "copy json path", buffer = true })
    end
  }
end
-- }}}

-- {{{ mason : package manager for LSP, DAP, linters, formatters
-- :MasonInstall js-debug-adapter
-- Site: https://github.com/mason-org/mason.nvim
local function plug_mason()
  return {
    "mason-org/mason.nvim",
    opts = {}
  }
end
-- }}}

-- {{{ nvim-dap : Debug Adapter Protocol client implementation
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
-- note: add debug adapter for nodejs using mason
local function plug_nvim_dap()
  return {
    "mfussenegger/nvim-dap",
    config = function ()
      local js_based_languages = { "typescript", "javascript", "typescriptreact" }

      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', "${port}"},
        }
      }

      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          -- mocha config for node.js testing
          {
            type = "pwa-node",
            request = "launch",
            name = "Mocha Tests",
            program = "${workspaceFolder}/node_modules/mocha/bin/_mocha",
            args = { "--timeout", "999999", "--colors", "${file}" },
            cwd = "${workspaceFolder}"
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Start Chrome with \"localhost\"",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
          }
        }
      end
    end
  }
end
-- }}}

-- {{{ nvim-dap-ui : Debug Adapter Protocol UI
-- see : https://github.com/rcarriga/nvim-dap-ui
-- A richer frienly UI for nvim-dap
local function plug_nvim_dap_ui()
  return {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} ,
    config = function ()
      require("dapui").setup()
          local wk = require("which-key")
          wk.add({
            { "<leader>d", group = "DAP" },
            { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "DAP Continue" },
            { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "DAP Step Into" },
            { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "DAP Step Over" },
            { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "DAP Step Out" },
            { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "DAP Toggle Breakpoint" },
            { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", desc = "DAP REPL Open" },
            { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "DAP UI Toggle" },
            { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "DAP UI Eval" },
          })
    end
  }
end
-- }}}

-- {{{ minimap : display a minimap on the right
-- see : https://github.com/wfxr/minimap.vim
-- started in dev mode
local function plug_minimap()
  return {
    "wfxr/minimap.vim",
    event = "VimEnter",
    config = function()
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
      vim.g.minimap_width = 8 --det fault 10
      vim.g.minimap_highlight_range = 1
      vim.g.minimap_highlight_search = 1
      vim.g.minimap_highlight_line = 1
      vim.g.minimap_git_colors = 1
      vim.g.minimap_auto_start_filetypes = {'markdown', 'yaml', 'json', 'html', 'css', 'scss', 'javascript', 'typescript', 'vue', 'go', 'lua'}
      vim.g.minimap_close_filetypes = {'NvimTree', 'TelescopePrompt', 'TelescopeResults'}
    end,
  }
end
-- }}}

-- {{{ Adding plugin to highlight trailing whitespace
-- https://github.com/ntpeters/vim-better-whitespace
-- To launch manual stripping of whitespaces :
-- :StripWhitespace
-- :EnableWhitespaces
local function plug_trailing_whitespaces()
  return {
    "ntpeters/vim-better-whitespace",
    version = "*", -- * means any OFFICIAL version
    event = { "BufEnter" },
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
local function plug_tcomment()
  return {
    'tomtom/tcomment_vim',
    event = "VeryLazy",
    config = function()
      -- Set the comment string for jsonc filetype
      -- Seems not supported out-of-the-box
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "jsonc",
        callback = function()
          vim.bo.commentstring = "// %s"
        end,
      })
    end
  }
  end
 -- }}}

-- {{{ vim-test : plugin to run tests inside vim
-- see https://github.com/vim-test/vim-test
-- Usage launch a test: :TestFile
local function plug_testfile()
  return {
    'vim-test/vim-test',
    ft = "typescript",
    cmd = "TestFile",
  }
end
-- }}}

-- {{{ neotest : plugin to autorun tests inside vim
-- see https://github.com/nvim-neotest/neotest
local function plug_neotest()
  return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio", -- A library for asynchronous IO in Neovim
    "nvim-lua/plenary.nvim", -- All the lua functions I don't want to write twice.
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    'adrigzr/neotest-mocha'
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-mocha')({
          command = "npm test --",
          command_args = function(context)
            -- The context contains:
            --   results_path: The file that json results are written to
            --   test_name: The exact name of the test; is empty for `file` and `dir` position tests.
            --   test_name_pattern: The generated pattern for the test
            --   path: The path to the test file
            --
            -- It should return a string array of arguments
            --
            -- Not specifying 'command_args' will use the defaults below
            return {
                "--full-trace",
                "--reporter=json",
                "--reporter-options=output=" .. context.results_path,
                "--grep=" .. context.test_name_pattern,
                context.path,
            }
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
      watch = {
        enabled = true,
        symbol_queries = {
          javascript = [[
          ;query
          ;Captures named imports
          (import_specifier name: (identifier) @symbol)
          ;Captures default import
          (import_clause (identifier) @symbol)
          ;Capture require statements
          (variable_declarator
          name: (identifier) @symbol
          value: (call_expression (identifier) @function  (#eq? @function "require")))
            ;Capture namespace imports
            (namespace_import (identifier) @symbol)
            ]],
          },
        }
    })
  end
}
end
-- }}}

-- {{{ gx : open links under cursor
-- see : https://github.com/chrishrb/gx.nvim
local function plug_gx()
  return {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- you can specify also another config if you want
    config = function() require("gx").setup {
      open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
      open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
      handlers = {
        plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
        brewfile = true, -- open Homebrew formulaes and casks
        package_json = true, -- open dependencies from package.json
        search = true, -- search the web/selection on the web if nothing else is found
      },
      handler_options = {
        -- search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
        search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
      },
    } end,
  }
end
 -- }}}

-- {{{ chatGPT : plugin to use OpenAI GPT-3 to generate text
-- see https://github.com/jackMort/ChatGPT.nvim
--
-- usage : ChatGPT
-- usage : ChatGPTRun explain_code
--
-- useful commands once dialog window open:
-- <C-y> apply changes
local function plug_chatGPT()
  return {
    "jackMort/ChatGPT.nvim",
    -- setting to VeryLazy and not CmdlineEnter
    -- as it can be used before throught key mapping
    event = "VeryLazy",
      -- see config possible here : https://github.com/jackMort/ChatGPT.nvim/blob/f1453f588eb47e49e57fa34ac1776b795d71e2f1/lua/chatgpt/config.lua#L10-L182
      -- key for real ChatGPT
      -- api_key_cmd = "pass show openai.com_apikey",
      -- key for llmproxy
      -- PATH
      -- make it use lm studio
      -- api_host_cmd = "echo http://localhost:1234",
      -- make it use llm proxy
      -- originally was changed in lua/chatgpt/flows/code_completions/init.lua#55
      -- see model list :
      -- https://platform.openai.com/docs/models/gpt-3-5-turbo
      -- model = "gpt-3.5-turbo-instruct",
      -- model = "gpt-3.5-turbo",
      -- model for llmproxy
    config = function()
      require("chatgpt").setup({
        actions_paths = {"~/dotvim/actions_chat_gpt_nbo.json"},
        api_key_cmd = "pass show llmproxy.ai.orange | head -n1",
        api_host_cmd = "echo https://llmproxy.ai.orange",
        api_type_cmd = "echo openai",
        openai_params = {
          model = "vertex_ai/claude3.5-sonnet-v2",
        },
        openai_edit_params = {
          model = "vertex_ai/claude3.5-sonnet-v2",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
end
-- }}}

-- {{{ render-markdown : plugin to render markdown in neovim
--
-- Used by avante, obsidian,...
-- see : https://github.com/MeanderingProgrammer/render-markdown.nvim
local function plug_render_markdown()
  return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
    },
    config = function()
      -- Set conceallevel=1 for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
        end
      })
    end

  }
end
-- }}}

-- {{{ avante : plugin to have cursor like function
-- see https://github.com/yetone/avante.nvim
-- Nécessite anthropic Claude, ou llm-proxy
-- voir dotfiles ENV var : ANTHROPIC_API_KEY
-- et ENV var : OPENAI_API_KEY
--
-- commande pour changer de provider :
--    AvanteSwitchProvider claude-llmproxy
local function plug_avante()
  return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*", -- * means any OFFICIAL version
    mode = "legacy", -- WARNING: Switch from "agentic" to "legacy". agentic is default and way too slow and complex
    opts = {
      debug = false, -- !!!!!
      -- The system_prompt type supports both a string and a function that returns a string
      -- Using a function here allows dynamically updating the prompt with mcphub
      system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub:get_active_servers_prompt()
      end,
      -- The custom_tools type supports both a list and a function that returns a list
      -- Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
          return {
              require("mcphub.extensions.avante").mcp_tool(),
          }
      end,
      behaviour = {
          auto_suggestions = false, -- Experimental stage
      },
      auto_suggestions_provider = "llmproxy_codestral",
      --
      -- Recommend using Claude
      -- provider = "llmproxy_openai", openai has issues with replace_in_file method
      provider = "llmproxy_claude3_7",
      providers= {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- timeout in milliseconds
          extra_request_body = {
            temperature = 0, -- adjust if needed
            max_tokens = 4096,
          }
          -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
        },
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          }
        },
        llmproxy_claude3_5 = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "vertex_ai/claude3.5-sonnet-v2",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 8000,
          }
        },
        llmproxy_claude3_7 = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "vertex_ai/claude3.7-sonnet",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 8000,
          }
        },
        llmproxy_openai = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "openai/gpt-4.1",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 8000,
          }
        },
        llmproxy_openai_mini = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "openai/gpt-4o-mini",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 8000,
          }
        },
        llmproxy_codestral = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "vertex_ai/codestral",
          timeout = 2000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0,
            max_tokens = 128000,
          }
        },
        -- see : https://github.com/yetone/avante.nvim/blob/46583943b67e68640568cac829c5fe08c69088ff/lua/avante/config.lua#L335
        llmproxy_gemini_2_0_flash = {
          endpoint = "https://llmproxy.ai.orange",
          __inherited_from = "openai",
          model = "vertex_ai/gemini-2.0-flash",
          context_window = 1048576,
          use_ReAct_prompt = true,
          timeout = 10000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75
          }
        },
      },
      -- Tool list: https://github.com/yetone/avante.nvim/tree/main/lua/avante/llm_tools
      --    rag_search, python, git_diff, git_commit, list_files, search_files, search_keyword, read_file_toplevel_symbols,
      --    read_file, create_file, rename_file, delete_file, create_dir, rename_dir, delete_dir, bash, web_search, fetch
      -- prompt tools usage guide :
      --    https://github.com/yetone/avante.nvim/blob/6f13034845f866726113f81c5dc07945e08e52db/lua/avante/templates/_tools-guidelines.avanterules
      -- description of tools sent to llm :
      --    https://github.com/yetone/avante.nvim/blob/6f13034845f866726113f81c5dc07945e08e52db/lua/avante/llm_tools.lua#L592
      disabled_tools = {"web_search"},
    },

    -- -- this is for RAG
    -- web_search_engine = {
    --   -- see : https://app.tavily.com
    --   provider = "tavily", -- tavily, serpapi or google
    -- },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- NBO : nécessaire car on atteint souvent le rate limit sur github pour download images
    -- et ça fail avec un message pas clair.
    build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    rag_service = {
      enabled = true, -- Enables the RAG service
      host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      provider = "openai-llmproxy", -- The provider to use for RAG service (e.g. openai or ollama)
      llm_model = "", -- The LLM model to use for RAG service
      embed_model = "azure/text-embedding-3-large", -- The embedding model to use for RAG service
      endpoint = "https://llmproxy.ai.orange/v1", -- The API endpoint for RAG service
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      'MeanderingProgrammer/render-markdown.nvim',
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  }
end
-- }}}

-- {{{ mcphub : plugin to have access to MCP APIs
-- WARNING : mcphub is used by avante
-- see https://github.com/ravitemer/mcphub.nvim
--
local function plug_mcphub()
  return {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest",  -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          }
        }
      })
    end,
}
end
-- }}}
--
--- {{{ coq : completion
-- rem : coq is not coc
-- see : https://github.com/ms-jpq/coq_nvim
-- alternative to nvim-cmp (https://github.com/hrsh7th/nvim-cmp/)
-- usage :COQdeps
-- then :COQnow
--
-- shortkey to force list display : ctr+space
--
-- METHODS SIGNATURE:
-- does not seem to work : https://github.com/ms-jpq/coq_nvim/issues/494
-- fallback on plugin : https://github.com/ray-x/lsp_signature.nvim
--
-- SNIPPPETS:
-- COQ will also propose snippets stored in folder nbo_snippets
-- To use snippets :COQsnips edit then COQsnips compile
--
-- ORIGIN of suggestions
-- BUF  ==> buffers
-- LSP  ==> Language Server Protocol
-- SNIP ==> Snippets
-- TS   ==> TreeSitter
local function plug_coq()
  return {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    event = "VeryLazy",
    config = function()
      -- making COQ reuse existing snippets folder
      -- it is the same format
      vim.g.coq_settings = {
        clients = {
          snippets = {
            enabled = true,
            user_path = vim.fn.stdpath('config')..'/nbo_snippets',
          },

        }
       }

      -- document this key mapping for which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "COQ" },
        { "<leader>cc", "<cmd>COQsnips compile<CR>", desc = "Coq Snips Compile" },
        { "<leader>cd", "<cmd>COQdeps<CR>", desc = "Coq Dependencies" },
        { "<leader>cn", "<cmd>COQnow<CR>", desc = "Coq Now" },
        { "<leader>cs", "<cmd>COQsnips edit<CR>", desc = "Coq Snips Edit" },
      })


      -- define alias "COQ" for "COQnow"
      -- to prevent calling COQdeps when typing COQ
      vim.cmd('command! -nargs=0 COQ COQnow')

    end,
  }
end
-- }}}

-- {{{ Plugin for autocompletion using nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
--
-- 2025-02-13 trying instead of COQ cause supported by obsidian.nvim
--            and avante
--
local function plug_cmp()
  return {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "petertriho/cmp-git",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-path",
      -- For luasnip users.
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      {
        "tzachar/cmp-ai",
        event = "VeryLazy",
        opts = function ()
          local cmp_ai = require('cmp_ai.config')

          cmp_ai:setup({
            max_lines = 1000,
            provider = 'OpenAI',
            provider_options = {
              model = 'vertex_ai/gemini-2.0-flash',
              raw_response_cb = function(response)
                -- the `response` parameter contains the raw response (JSON-like) object.

                vim.notify(vim.inspect(response)) -- show the response as a lua table

                vim.g.ai_raw_response = response -- store the raw response in a global
                -- variable so that you can use it
                -- somewhere else (like statusline).
              end,
            },
            notify = true,
            notify_callback = function(msg)
              vim.notify(msg)
            end,
            run_on_every_keystroke = false, -- WARNING FALSE == DISABLE THIS PLUGIN
            ignored_file_types = {
              -- default is not to ignore
              -- uncomment to ignore in lua:
              -- lua = true
            },
          })
        end
      },
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = 'cmp_ai' },
          { name = "path" },
          { name = "buffer" },
          { name = "git" },
          { name = "omni" },
          { name = "luasnip" },
          { name = "yank" }
        }),
        formatting = {
          format = function(entry, item)

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        experimental = {
          -- only show ghost text when we show ai completions
          ghost_text = vim.g.ai_cmp and {
            hl_group = "CmpGhostText",
          } or false,
        },
        sorting = defaults.sorting,
      }
    end
  }
end
-- }}}

-- {{{ Plugin for snippets for cmp
local function plug_luasnip()
  return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  }
end
-- }}}

-- {{{ Plugin for adding 3rd party integrations with COQ
local function plug_coq_3p()
  return {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
    -- https://github.com/ms-jpq/coq.thirdparty
    config = function()
      require("coq_3p") {
        -- 2024-06-04 Sadly does not work cause numerous calls leads to type change and type error
        -- { src = "tabby", short_name = "TAB" },
        -- See https://github.com/ms-jpq/coq.thirdparty/tree/3p?tab=readme-ov-file#comment-banner
        { src = "figlet", short_name = "BIG", trigger = "!big"}
      }
    end
  }
end
--  }}}

-- {{{ Plugin for displaying method signature using LSP
-- see https://github.com/ray-x/lsp_signature.nvim
-- WARNING <C-k> and <leader>k will work only if cursor is in parenthesis not on function name
local function plug_lsp_signature()
  return {
      "ray-x/lsp_signature.nvim",
      opts = {
        debug=true,
        transparency=20
      },
      config = function(_, opts)
        require'lsp_signature'.setup(opts)

        -- adding keymaps
        vim.keymap.set({ 'n' }, '<C-k>', function()       require('lsp_signature').toggle_float_win() end, { silent = true, noremap = true, desc = 'toggle signature' })

        vim.keymap.set({ 'n' }, '<Leader>k', function() vim.lsp.buf.signature_help() end, { silent = true, noremap = true, desc = 'toggle signature' })
      end
    }
  end
-- }}}

-- {{{ Plugin to perform file operations (rename, delete, etc) in nvim-tree and have code change using LSP
local function plug_lsp_file_operations()
  return {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  }
end
-- }}}

-- {{{ Plugin for making REST request using Curl
-- https://github.com/diepm/vim-rest-console
-- usage :
-- :set ft=rest
-- http://localhost:9200
-- GET /_cat/nodes?v|
-- <C-J>
local function plug_rest()
  return {
    'diepm/vim-rest-console',
    ft="rest",
    config = function ()
      vim.cmd('autocmd FileType rest setlocal nospell')
      vim.g.vrc_horizontal_split=1
    end,
  }
end
-- }}}

-- {{{ rainbow_csv : plugin for editing csv tsv formatted files
-- https://github.com/mechatroner/rainbow_csv
-- useful commands :
-- :RainbowAlign
-- :Select a1,a4 order by a11
local function plug_rainbow_csv()
  return {
    'mechatroner/rainbow_csv',
    ft = {'csv', 'tsv'},
    config = function()
      -- removing line wrapping on csv
      vim.cmd('autocmd FileType csv setlocal nowrap')
    end,
  }
end
-- }}}

-- {{{ folke/trouble.nvim : display errors, including lsp, correctly
-- https://github.com/folke/trouble.nvim
-- usage :Trouble
local function plug_trouble()
  return {
    'folke/trouble.nvim',
    -- 2024-06-06 : version 3.1 and 3.2 seem to be buggy
    -- Trouble command is not defined
    version="v2.9.1",
    cmd="Trouble",
    dependencies= {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
        mode = "loclist",
        auto_open = false,
        auto_close = true,
        height = 6, --default 10
    },

    config = function()
      -- key mapping to jump to next items skipping groups
      -- local wk = require("which-key")
      -- wk.register({ t = { ":lua require('trouble').next({skip_groups = true, jump = true});", "Trouble next" } }, { prefix = "g" })
    end
  }
end
-- }}}

-- {{{ Plugin to support syntax for taskwarrior config files
-- Plug 'nbossard/vim-taskwarrior-conf', {'for': 'taskrc'}
local function plug_vim_taskwarrior_conf()
  return {
    "nbossard/vim-taskwarrior-conf",
    version = "*",
    lazy = true,
  }
end
-- }}}

-- {{{ To support PlantUML File syntax
-- See: https://github.com/aklt/plantuml-syntax
local function plug_plantuml_syntax()
  return {
    "aklt/plantuml-syntax",
    version = "*",
    lazy = true,
    ft = "plantuml",
    config = function()
      -- set foldmethod=syntax
      vim.cmd('autocmd Filetype plantuml setlocal foldmethod=syntax')
      vim.g.plantuml_executable_script='plantuml -DPLANTUML_LIMIT_SIZE=8192 -verbose'
    end,
  }
end
-- }}}

-- {{{ To support Gitleaksignore File syntax
-- See: https://github.com/nbossard/gitleaksignore-syntax
local function plug_gitleaksignore_syntax()
  return {
    "nbossard/gitleaksignore-syntax",
    version = "*",
    config = function()
      -- set foldmethod=syntax
      vim.cmd('autocmd Filetype gitleasignore setlocal foldmethod=syntax')
    end,
  }
end
-- }}}

-- {{{ Plugin to support Go Language (golang)
-- https://github.com/ray-x/go.nvim
-- Replaces fatih/vim-go written in vimscript mostly
-- Rem : needs to install a tree-sitter parser
--`:TSInstallSync go`
-- For debugging, see https://github.com/mfussenegger/nvim-dap
local function plug_x_go()
  return
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages, removed nvim-lspconfig dependency
        "ray-x/guihua.lua",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
        -- foldmethod is set by Treesitter

        -- Run gofmt on save
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            require('go.format').gofmt()
          end,
          group = format_sync_grp,
        })

      end,
      ft = {"go", 'gomod'}, -- Lazy load on filetype go
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
end
-- }}}

-- {{{ Plugin for coloring gomod files
-- https://github.com/maralla/gomod.vim
local function plug_coloring_gomod()
  return {
    'maralla/gomod.vim',
    ft = {'gomod'},
  }
end
-- }}}

---{{{ obsidian.nvim: plugin for obsidian in neovim
local function plug_obsidian()
  return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    cmd = {
       "ObsidianSearch","ObsidianToday",
    },
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim", -- All the lua functions I don't want to write twice.
    },
    opts = {
      preferred_link_style = "markdown",

      -- Optional, customize how markdown links are formatted.
      markdown_link_func = function(opts)
        return require("obsidian.util").markdown_link(opts)
      end,

      disable_frontmatter = true,
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-e>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-e>",
        },
      },
      workspaces = {
        {
          name = "personal",
          path = "~/perso/obsidian/obsperso",
          templates = {
            folder = "my-templates-folder",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
          },
          overrides = {
            daily_notes = {
              -- Optional, if you keep daily notes in a separate directory.
              folder = "Agenda",
              -- Optional, if you want to change the date format for the ID of daily notes.
              date_format = "%Y-%m-%d",
              -- Optional, default tags to add to each new daily note created.
              default_tags = {},
              -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
              template = "daily.md"
            }
          }
        },
        {
          name = "business-server",
          path = "~/PilotageDistri/business-server",
          overrides = {
            templates = {
              folder = "documentation/TemplatesObsidian",
              date_format = "%Y-%m-%d",
              time_format = "%H:%M",
            },
            daily_notes = {
              -- Optional, if you keep daily notes in a separate directory.
              folder = "documentation/Agenda",
              -- Optional, if you want to change the date format for the ID of daily notes.
              date_format = "%Y-%m-%d",
              -- Optional, default tags to add to each new daily note created.
              default_tags = {},
              -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
              template = "daily.md"
            },
          }
        },
        {
          name = "business-server",
          path = "~/PilotageDistri/business-server-dev",
          overrides = {
            templates = {
              folder = "documentation/TemplatesObsidian",
              date_format = "%Y-%m-%d",
              time_format = "%H:%M",
            },
            daily_notes = {
              -- Optional, if you keep daily notes in a separate directory.
              folder = "documentation/Agenda",
              -- Optional, if you want to change the date format for the ID of daily notes.
              date_format = "%Y-%m-%d",
              -- Optional, default tags to add to each new daily note created.
              default_tags = {},
              -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
              template = "daily.md"
            },
          }
        },
      },
    },
  }
end
---}}}

-- {{{ scrollbar : display a scrollbar on the right for info (not for clicking)
-- See : https://github.com/Xuyuanp/scrollbar.nvim
-- Rem : Does not work on vim, only for neovim
-- Same usage as minimap but seems much more stable
local function plug_scrollbar()
  return {
    'Xuyuanp/scrollbar.nvim',
    event = "BufEnter",
    config = function()
      vim.cmd([[
      augroup ScrollbarInit
        autocmd!
        autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
        autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
        autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
      augroup end
      ]])
    end
  }
end
-- }}}

-- {{{ bufdel : close buffer without deleting window
-- see : https://github.com/ojroques/nvim-bufdel
-- replacing previously used : vim-bbye https://github.com/moll/vim-bbye
local function plug_bufdel()
  return {
    "ojroques/nvim-bufdel",
    event = "VeryLazy",
    config = function()
      require('bufdel').setup {
        next = 'tabs',
        quit = false,  -- quit Neovim when last buffer is closed
      }
      vim.cmd('abbreviate bdd BufDel')
      vim.cmd('abbreviate bda BufDelAll')
    end
  }
end
-- }}}

-- {{{ nvim-colorizer.lua : to colorize color codes in files
-- see: https://github.com/norcalli/nvim-colorizer.lua
local function plug_colorizer()
  return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
}
end
-- }}}

-- {{{ nvim-coverage : plugin to display code coverage in the gutter
-- to test code coverage with  c8
-- c8 --reporter=lcov mocha "tests/**/*.test.js"
-- usage :CoverageLoad
local function plug_disp_coverage()
  return {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("coverage").setup({
        lang = {
          javascript = {
            coverage_file = "coverage/lcov.info",
          }
        }
      })
    end
  }
end
-- }}}

-- {{{ nvim-surround : plugin for surrounding text with quotes, brackets, etc
-- see : https://github.com/kylechui/nvim-surround
-- rem : surround selection : key is "S"
-- see : https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
local function plug_surround()
  return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }
end
-- }}}

-- {{{ vim-CtrlXA : plugin to toggle between predefined values
-- see : https://github.com/Konfekt/vim-CtrlXA
-- Usage : traditional <C-X> or <C-A>
local function plug_ctrlxa()
  return {
    'Konfekt/vim-CtrlXA',
    event = "VeryLazy",
    config = function()
      -- Set up mappings for SpeedDating fallback
      vim.cmd([[
        nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
        nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
      ]])
      
      -- Define global toggles
      vim.g.CtrlXA_Toggles = {
        {'Nicolas', 'James'},
        {'BOSSARD', 'ZHIHONG_GUO'},
        {'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'},
        {'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'},
        {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'},
      }
      
      -- Additional rules for JavaScript
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "javascript",
        callback = function()
          vim.b.CtrlXA_Toggles = {
            {'DOIT', 'SKIPIT'},
            {'FAKE', 'DOCHANGES'},
            {'us', 'task'},
            {'POST', 'GET', 'PUT', 'DELETE'},
          }
          vim.cmd('let b:CtrlXA_Toggles = b:CtrlXA_Toggles + g:CtrlXA_Toggles')
        end
      })
      
      -- Additional rules for cucumber/feature files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cucumber",
        callback = function()
          vim.b.CtrlXA_Toggles = {
            {'Given', 'When', 'Then', 'And', 'But'},
          }
          vim.cmd('let b:CtrlXA_Toggles = b:CtrlXA_Toggles + g:CtrlXA_Toggles')
        end
      })
      
      -- Additional rules for REST files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rest",
        callback = function()
          vim.b.CtrlXA_Toggles = {
            {'GET', 'POST', 'PUT', 'DELETE'},
          }
          vim.cmd('let b:CtrlXA_Toggles = b:CtrlXA_Toggles + g:CtrlXA_Toggles')
        end
      })
      
      -- Additional rules for taskedit files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "taskedit",
        callback = function()
          vim.b.CtrlXA_Toggles = {
            {'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'},
            {'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'},
            {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'},
          }
          vim.cmd('let b:CtrlXA_Toggles = b:CtrlXA_Toggles + g:CtrlXA_Toggles')
        end
      })
    end
  }
end
-- }}}

-- {{{ ===== Various color scheme s ====

local function plug_color_scheme_gruvbox()
  return {
    -- 'morhetz/gruvbox',
    'ellisonleao/gruvbox.nvim', -- better support of treesitter ?
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end
  }
end

-- used by documentation repository
local function plug_color_scheme_dracula()
  return {
    'dracula/vim',
  }
end

-- from neovim conf
local function plug_color_solarized_osaka()
  return {
    'craftzdog/solarized-osaka.nvim',
    event = "VeryLazy",
  }
end
-- }}}



require("lazy").setup({
  plug_copilot(), -- stopplspconfig.gopls.setuped paying
  -- plug_tabby(),
  plug_surround(),
  plug_start_screen(),
  plug_which_key(),
  plug_mini_icons(),
  -- plug_lspconfig(), -- NBO: 2025-01-31 Removed - not needed in Neovim 0.11+, using built-in vim.lsp.config()
  plug_lsp_inlay_hints(),
  plug_ripgrep_multiline(),
  plug_vista(),
  -- plug_vimghost(),
  plug_ale(),
  plug_ctrlxa(),
  plug_mark(),
  plug_treesitter(),
  plug_treesitter_context(),
  plug_treesj(),
  plug_trouble(),
  plug_nvim_tree(),
  plug_lualine(),
  plug_gitsigns(),
  plug_lazyjui(),
  plug_trailing_whitespaces(),
  plug_vim_taskwarrior_conf(),
  plug_tcomment(),
  plug_plantuml_syntax(),
  plug_gitleaksignore_syntax();
  plug_x_go(),
  plug_coloring_gomod(),
  plug_telescope(),
  plug_testfile(),
  plug_neotest(),
  plug_gx(),
  -- plug_chatGPT(),
  plug_render_markdown(),
  plug_avante(),
  plug_mcphub(),
  plug_luasnip(),
  -- plug_coq(),
  -- plug_coq_3p(),
  plug_cmp(), -- replacing COQ
  plug_lsp_signature(),
  plug_lsp_file_operations(),
  plug_rest(),
  plug_rainbow_csv(),
  plug_rgflow(),
  plug_jsonpath(),
  plug_mason(),
  plug_nvim_dap(),
  plug_nvim_dap_ui(),
  plug_minimap(),
  plug_scrollbar(),
  plug_bufdel(),
  plug_obsidian(),
  'glacambre/firenvim',
  -- plug_lsp_lines(),
  plug_colorizer(),
  -- to generate UUIDs
  {{"tokikokoko/uuid-rs.nvim", build = ":UuidBuild"}},
  plug_disp_coverage(),


  plug_color_scheme_gruvbox(),
  plug_color_scheme_dracula(),
  plug_color_solarized_osaka(),
})

-- vim.diagnostic is Neovim’s built-in diagnostics system.
-- it’s the API Neovim uses to receive, store, display, and manage errors, warnings, and hints from tools like LSP servers, linters, and formatters.
-- configure vim diagnostics to use virtual_lines only for current line
-- debug with :lua print(vim.inspect(vim.diagnostic.config()))
vim.diagnostic.config({ underline = true, virtual_text = true, virtual_lines = { current_line =true } })

-- cucumber filetype default settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cucumber",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'glp', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gln', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local wk = require("which-key")
    -- g prefix
    wk.add({ { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "LSP Goto Definition" }, })
    wk.add({ { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "LSP Goto Declaration" }, })
    wk.add({ { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "LSP Goto Implementation" }, })
    wk.add({
      { "<leader>l", group = "LSP" },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "LSP Code Action" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", desc = "LSP Format" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "LSP Rename" },
    })

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
})
-- }}}

-- Adding command to insert current date
-- for use in changelog by example
-- imap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>
vim.keymap.set('i', '<C-d>', function() vim.fn.strftime('%Y-%m-%d') end)

-- Keep at least 5 lines visible at top and bottom of screen
vim.opt.scrolloff=5

-- Adding command to generate a random password
-- for use in 'pass edit'
-- vim.cmd('command! r!pwgen --no-vowels --numerals --symbols --remove-chars "\"~" 16 1 Password')
vim.cmd("command! -nargs=0 Password :r!pwgen --no-vowels --numerals --symbols --remove-chars \"'\\\"~\" 16 1")
-- command Password :r!pwgen --no-vowels --numerals --symbols --remove-chars "'\"~" 16 1

-- synchronize system clipboard with vim clipboard
vim.api.nvim_set_option("clipboard","unnamed")

-- Shortcuts to move lines up or down
vim.cmd("nnoremap <C-j> :m .+1<CR>==")
vim.cmd("nnoremap <C-k> :m .-2<CR>==")

-- Changing search method to use smartcase
vim.cmd("set ignorecase smartcase")

-- Allow search of currently selected text using //
vim.api.nvim_set_keymap('v', '//', 'y/<C-R>"<CR>', {})
-- Allow clearing of searched text using ///
vim.api.nvim_set_keymap('n', '///', ':nohl<CR>', {})

-- set search as ignorecase
vim.cmd("set ignorecase")

-- define alias to launch vista and COQ in one single command
-- vim.cmd('command! -nargs=0 Dev :Vista<CR> | COQnow<CR>')
function DevMode()
  -- vim.cmd('Minimap')
  vim.cmd('Trouble')
  vim.cmd('Vista')
  vim.cmd('COQnow')
end
vim.cmd('command! -nargs=0 Dev lua DevMode()')


-- Adding alias to open finder in file current directory
-- Useful for quick pasting of screenshot in folder
vim.cmd('command! -nargs=0 Finder !open %:p:h')

-- {{{ spell related config
-- Enable spell checking and set spell languages (English and French)
--
-- Usual commands :
-- zg => add word to dico
-- zw => remove word from dico
-- z= => suggest word
--
-- List of exception words are stored in "spell" folder
-- To check the spell file used :
--    :set spellfile?
-- To configure another file in a project configuration :
--    vim.opt.spellfile = '~/.config/nvim/spell/en.utf-8.add'
--
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'fr' }
-- Add spell suggestions defined by the user on top of default suggestions
vim.opt.spellsuggest = { 'file:/Users/nbossard/dotvim/spell_suggestions.txt', 'best' }
-- {{{key shortcuts
local wk = require("which-key")
-- g prefix
wk.add({ { "gsn", "]s", desc = "Go to next spell issue" }, })
wk.add({ { "gsp", "[s", desc = "Go to previous spell issue" }, })
-- }}}
-- }}}

-- Adding command to insert current date
-- for use in changelog by example
vim.cmd('imap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>')

-- {{{ Customize the appearance of hidden characters
-- reminder to use it type ":set list"
vim.opt.listchars = {
    space = '⋅',      -- Display spaces as ⋅ (you can use any character)
    tab = '→ ',       -- Display tabs as → followed by a space
    eol = '↴',        -- Display end of line as ↴
    trail = '·',      -- Display trailing spaces as ·
    extends = '⟩',    -- Display extends with ⟩
    precedes = '⟨'    -- Display precedes with ⟨
}
-- }}}

-- NDJSON files should be colored as JSON5
vim.cmd([[autocmd BufNewFile,BufRead *.ndjson setfiletype json5]])

-- makefile preferences
-- Json related config : Prettier compatible formatting with two spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "makefile", "make" },
  callback = function()
    vim.opt_local.list = true
    vim.opt_local.expandtab = false
  end
})

-- {{{ improve diff
local function file_exists(filepath)
    local f = io.open(filepath, "r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

function DiffFiles(file2)
    local file1 = vim.fn.expand('%:p')  -- Obtenir le chemin complet du tampon actuel

    if not file_exists(file1) then
        print("Fichier actuel introuvable : " .. file1)
        return
    end
    if not file_exists(file2) then
        print("Fichier introuvable : " .. file2)
        return
    end

    -- Dans un nouveau tab
    vim.cmd('tabnew')

    -- Ouvrir le premier fichier dans une nouvelle fenêtre
    vim.cmd('edit ' .. file1)
    vim.cmd('diffthis')
    vim.cmd('setlocal scrollbind')  -- Activer le scrollbind pour le premier fichier
    vim.cmd('vsplit')
    vim.cmd('wincmd l')

    -- Ouvrir le deuxième fichier dans la même fenêtre
    vim.cmd('edit ' .. file2)
    vim.cmd('diffthis')
    vim.cmd('setlocal scrollbind')  -- Activer le scrollbind pour le deuxième fichier
end

-- Créer un alias de commande pour DiffFiles avec complétion de fichiers
vim.api.nvim_create_user_command('DiffFiles', function(opts)
    DiffFiles(opts.args)
end, {
    nargs = 1,
    desc = "Compare current buffer with specified file in a new tab",
    complete = function(ArgLead, CmdLine, CursorPos)
        -- Utiliser la complétion de fichiers intégrée
        return vim.fn.getcompletion(ArgLead, 'file')
    end
})
--}}}

-- {{{ Set up an autocommand for files containing API keys
-- to replace keys by 🔑, to prevent accidental display in conf
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*API_KEYS.sh", "*.env", ".env*", "*.json", "config.yaml"},
    callback = function()
        -- Enable concealment for the buffer
        vim.wo.conceallevel = 2

        -- Define the concealment patterns
        vim.cmd([[
            " Match API keys including the quotes and export statements
            " Anthropic or Open AI or LLM proxy keys
            syntax match ApiKey /\v"sk-([a-zA-Z0-9-_]{22,})"/ conceal cchar=🔑
            syntax match ApiKey /\vsk-([a-zA-Z0-9-_]{22,})/ conceal cchar=🔑
            " Tavily keys
            syntax match ApiKey /\v"tvly[a-zA-Z0-9_-]{32,}"/ conceal cchar=🔑
        ]])
    end
})
-- }}}

-- {{{ changing vim default behaviour on registers
-- make register 1-9 contain also yank history
-- not only deleted history
vim.cmd([[
function! SaveLastReg()
    if v:event['regname']==""
        if v:event['operator']=='y'
            for i in range(8,1,-1)
                exe "let @".string(i+1)." = @". string(i)
            endfor
            if exists("g:last_yank")
                let @1=g:last_yank
            endif
            let g:last_yank=@"
        endif
    endif
endfunction
:autocmd TextYankPost * call SaveLastReg()
]])
-- }}}

-- vim.cmd([[
-- augroup go_with_java
--   autocmd!
--   autocmd FileType go syntax include @java syntax/java.vim
--   autocmd FileType go syntax region javaBlock start='\/\*JAVA\*\/' end='\/\*ENDJAVA\*\/' contains=@java
-- augroup END
-- ]])

-- {{{ automatically load project specific init.lua
-- in current folder or in parents till /
local function find_project_config()
    local current_dir = vim.fn.getcwd()
    while current_dir ~= "/"  and current_dir ~= vim.fn.expand("~") and current_dir ~= vim.fn.expand("~/dotvim") do
        local config_path = current_dir .. '/init.lua'
        if vim.fn.filereadable(config_path) == 1 then
            return config_path
        end
        current_dir = vim.fn.fnamemodify(current_dir, ":h")
    end
    return nil
end
local project_config = find_project_config()
if project_config then
    vim.notify("Chargement de la configuration du projet depuis " .. project_config, vim.log.levels.INFO)
    dofile(project_config)
end
-- }}}
