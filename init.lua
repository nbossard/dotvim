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

-- lazy configuration options
-- event = "VimEnter" -- lazy load when vim starts
-- event = "VeryLazy" -- lazy load when a plugin is used
-- event = "BufEnter" : lazy load when a buffer is opened
-- event = "CmdlineEnter" : lazy load when a command is run
-- ft = "typescript",

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
local function plug_tabby()
  return {
  "TabbyML/vim-tabby",
  config = function()
    vim.g.tabby_keybinding_accept = '<Tab>'
    -- can be found here : http://localhost:8080/
    vim.g.tabby_token= 'auth_9a8a149b6a634cb79a31268110d48eac'
  end,
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
--- }}}

-- {{{ ALE : Asynchronous Lint Engine
-- see : https://github.com/dense-analysis/aleo
-- Usage : :ALEFix to make Prettier fix the file
--   see g:ale_fixers below
local function plug_ale()
  -- define a new alias ":Prettier" as an alias to ALEFix
  vim.cmd('command! -nargs=0 Prettier echo "Use :ALEFix"')

  return {
    "dense-analysis/ale",
    ft = "typescript,json,yaml,markdown,css,scss,html,vue,lua",
    config = function()
      vim.g.ale_fixers = {
        typescript = {'prettier'},
        javascript = {'prettier'},
        json = {'prettier'},
        yaml = {'prettier'},
        markdown = {'prettier'},
        css = {'prettier'},
        scss = {'prettier'},
        html = {'prettier'},
        vue = {'prettier'}
      }
      -- key mapping to Fix the file
      -- document this key mapping for which-key
      local wk = require("which-key")
      wk.register({ a = { "<cmd>ALEFix<cr>", "ALE Fix" } }, { prefix = "<leader>" })
    end,
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
    event="BufRead",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "lua", "go" },
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,
        -- List of parsers to ignore installing (or "all")
        ignore_install = {},
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,
        highlight = {
          enable = true,
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

      -- treesitter breaks foldmethod=syntax (sic)
      -- but works like this
      vim.cmd("autocmd Filetype go set foldmethod=expr")
      vim.cmd("autocmd Filetype go set foldexpr=nvim_treesitter#foldexpr()")
    end
  }
end
--}}}

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
  require("nvim-tree.api").tree.open()
end
-- config function to setup nvim-tree
local function plug_nvim_tree()
  return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      -- optional used to show icons in the tree
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
      -- Define the alias for previous plugin Nerdtree
      vim.cmd('command! -nargs=0 NERDTree echo "Use :NvimTreeOpen"')
      -- key mapping to open current file in nvim-tree
      -- document this key mapping for which-key
      local wk = require("which-key")
      wk.register({ g = { n =  { F = { "<cmd>NvimTreeFindFile<cr>", "Locate current file in nvim-tree" }, }, }, })
      -- launch at start
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  }
end
--- }}}

-- {{{ gitsigns : to display a git column markers in the gutter
-- close to line numbers
-- see : https://github.com/lewis6991/gitsigns.nvim
-- Usage : :Gitsigns
-- Replacing GitGutter
local function plug_gitsigns()
   return {
    "lewis6991/gitsigns.nvim",
    version = "*",
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
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
      }
      local wk = require("which-key")
      -- add key map for go to next/previous hunk
      wk.register({g = {h = {
        name="Git Hunk",
        n = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next hunk" },
        p = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous hunk" },
        b = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame line" },
      }, }})
      -- add other key maps
      wk.register({ h = {
        name="Git Hunk",
        r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset hunk" },
        p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview hunk" },
        s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage hunk" },
        d = { "<cmd>lua require('gitsigns').diffthis()<cr>", "Diff this" },
      }}, {prefix="<leader>", mode="n"})
    end,
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
    require('lualine').setup({})
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
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- adding alias used when using ripgrep
      -- alias ":Rg" to ":Telescope live_grep"
      vim.cmd('command! -nargs=0 Rg Telescope live_grep')
      vim.cmd('abbreviate rg Rg')
      -- adding alias used when using plugin bufexplore
      -- <leader>be to open buffers
      -- OLD STYLE replaced by which key register : vim.keymap.set('n','<leader>be', ':Telescope buffers<CR>')
      local wk = require("which-key")
      wk.register({
        b = {
          name = "buffer", -- optional group name
          e = { "<cmd>Telescope buffers<cr>", "Show buffers list" } -- create a binding with label
        },
        f = {
          name = "file", -- optional group name
          f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
          r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File"} -- additional options for creating the keymap
        }
      }, {prefix = "<leader>"})

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

        wk.register({ r = { name = "rgflow",
          g = {":lua require('rgflow').open_blank()<cr>", "open UI - search pattern = blank"},
          G = {":lua require('rgflow').open_cword()<cr>", "open UI - search pattern = <cword>"},
          p = {":lua require('rgflow').open_paste()<cr>", "open UI - search pattern = First line of unnamed register as the search pattern"},
          a = {":lua require('rgflow').open_again()<cr>", "open UI - search pattern = Previous search pattern"},
          c = {":lua require('rgflow').print_cmd()<cr>", "Print last run for paste shell"},
        }}, {prefix = "<leader>", mode = "n"})
    end,
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
      vim.g.minimap_width = 8 --default 10
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
local function plug_trailing_whitespaces()
  return {
    "ntpeters/vim-better-whitespace",
    version = "*",
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
    event = "VeryLazy"
  }
end
 -- }}}

-- {{{ vim-test : plugin to run tests inside vim
-- see https://github.com/vim-test/vim-test
-- Usage : :TestFile
local function plug_testfile()
  return {
    'vim-test/vim-test',
    ft = "typescript",
    cmd = "TestFile",
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
-- useful commands once dialog window open:
-- <C-y> apply changes
local function plug_chatGPT()
  return {
    "jackMort/ChatGPT.nvim",
    -- setting to VeryLazy and not CmdlineEnter
    -- as it can be used before throught key mapping
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        actions_paths = {"~/dotvim/actions_chat_gpt_nbo.json"},
        -- key for real ChatGPT
        api_key_cmd = "pass show openai.com_apikey",
        -- make it use lm studio
        api_host_cmd = "echo http://localhost:1234",
      })


      -- document this key mapping for which-key
      local wk = require("which-key")
      -- do not use "c" as it is already used by COQ
      wk.register({ g = { name = "ChatGPT",
        c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
        e = { "<cmd>ChatGPTEditWithInstruction<CR>", "ChatGPT Edit with instruction", mode = { "n", "v" } },
        g = { "<cmd>ChatGPTRun grammar_correction<CR>", "ChatGPT Grammar Correction", mode = { "n", "v" } },
        t = { "<cmd>ChatGPTRun translate<CR>", "ChatGPT Translate", mode = { "n", "v" } },
        k = { "<cmd>ChatGPTRun keywords<CR>", "ChatGPT Keywords", mode = { "n", "v" } },
        d = { "<cmd>ChatGPTRun docstring<CR>", "ChatGPT Docstring", mode = { "n", "v" } },
        a = { "<cmd>ChatGPTRun add_tests<CR>", "ChatGPT Add Tests", mode = { "n", "v" } },
        o = { "<cmd>ChatGPTRun optimize_code<CR>", "ChatGPT Optimize Code", mode = { "n", "v" } },
        s = { "<cmd>ChatGPTRun summarize<CR>", "ChatGPT Summarize", mode = { "n", "v" } },
        f = { "<cmd>ChatGPTRun fix_bugs<CR>", "ChatGPT Fix Bugs", mode = { "n", "v" } },
        x = { "<cmd>ChatGPTRun explain_code<CR>", "ChatGPT Explain Code", mode = { "n", "v" } },
        l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "ChatGPT Code Readability Analysis", mode = { "n", "v" } },
      }}, {prefix = "<leader>"})
      -- Adding shortcut for completion in insert mode
      vim.keymap.set('i', '<C-Space>', '<cmd>ChatGPTComplete<CR>')

    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
end
-- }}}

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
-- ORIGIN of suggestions : 
-- BUF  ==> bufers
-- LSP  ==> Language Server Protocol
-- SNIP ==> Snippets
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
      wk.register({ c = { name = "COQ",
        d = { "<cmd>COQdeps<CR>", "Coq Dependencies" },
        n = { "<cmd>COQnow<CR>", "Coq Now" },
        s = { "<cmd>COQsnips edit<CR>", "Coq Snips Edit" },
        c = { "<cmd>COQsnips compile<CR>", "Coq Snips Compile" },
      }}, {prefix = "<leader>"})


      -- define alias "COQ" for "COQnow"
      -- to prevent calling COQdeps when typing COQ
      vim.cmd('command! -nargs=0 COQ COQnow')

    end,
  }
end
-- }}}


-- {{{ Plugin for displaying method signature using LSP
-- see https://github.com/ray-x/lsp_signature.nvim
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
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
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

-- }}}

-- {{{ ===== Various colorscheme s ====

local function plug_color_scheme_gruvbox()
  return {
    'morhetz/gruvbox',
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end
  }
end

-- usedd by documentation repository
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
  -- plug_copilot(), -- stopped paying
  plug_tabby(),
  plug_which_key(),
  "folke/neodev.nvim", -- luas development
  'nvim-lspconfig',
  'liuchengxu/vista.vim', -- ctags equivalent, commande :Vista
  plug_ale(),
  plug_treesitter(),
  plug_trouble(),
  plug_nvim_tree(),
  plug_lualine(),
  plug_gitsigns(),
  plug_trailing_whitespaces(),
  plug_vim_taskwarrior_conf(),
  plug_tcomment(),
  plug_plantuml_syntax(),
  plug_x_go(),
  plug_coloring_gomod(),
  plug_telescope(),
  plug_testfile(),
  plug_gx(),
  plug_chatGPT(),
  plug_coq(),
  plug_lsp_signature(),
  plug_rest(),
  plug_rainbow_csv(),
  plug_rgflow(),
  plug_minimap(),
  plug_scrollbar(),

  plug_color_scheme_gruvbox(),
  plug_color_scheme_dracula(),
  plug_color_solarized_osaka(),
})


-- {{{ LSP config
-- https://github.com/neovim/nvim-lspconfig
-- See : LspInfo
--
-- Error messages are displayed inlined with the code, usually too long
-- Using folke/trouble.nvim to display them in a separate window

-- For JavaScript and TypeScript
-- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
-- npm install -g typescript typescript-language-server
-- NOTE : the setup lsp_ensure_capabilities is to support COQ snippets
require'lspconfig'.tsserver.setup{
  capabilities = require('coq').lsp_ensure_capabilities(),
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue"
  }
}
vim.cmd("autocmd FileType typescript setlocal foldmethod=syntax")

-- For Angular
-- See doc here : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls
-- npm install -g @angular/language-server
require'lspconfig'.angularls.setup{}
-- For bash
-- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
-- npm install -g bash-language-server
require'lspconfig'.bashls.setup{}
-- For Golang
-- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
require'lspconfig'.gopls.setup{}
-- For JSON
-- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
-- npm install -g vscode-langservers-extracted
require'lspconfig'.jsonls.setup {}
-- For Dockerfiles
-- see doc here https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{}
-- For Lua
-- Install server using `brew install lua-language-server`
-- See setup config here https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
require'lspconfig'.lua_ls.setup{
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

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
    wk.register({ g = { d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP Goto Definition" }, mode = { "n" } }})
    wk.register({ g = { D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP Goto Declaration" }, mode = { "n" } }})
    wk.register({ g = { i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP Goto Implementation" }, mode = { "n" } }})
    wk.register({ g = { r = { "<cmd>lua vim.lsp.buf.references()<cr>", "LSP Goto References" }, mode = { "n" } }})
    -- leader prefix
    wk.register({ l = { r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP Rename" }, mode = { "n" } } } , {prefix = "<leader>"})
    wk.register({ l = { f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "LSP Format" } } }, { prefix = "<leader>" })
    wk.register({ l = { a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP Code Action" } } }, { prefix = "<leader>" })

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
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

-- call prettier from neovim without any plugin
-- suppose prettier is installed globally
-- :!prettier --write %
--
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

-- changing vim default behaviour on registers
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
