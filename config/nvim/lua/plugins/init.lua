local core_mappings = require 'core.mappings'

require('lazy').setup({
  {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
      -- snippet engine, required by cmp
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          -- snippets!
          'rafamadriz/friendly-snippets',
        },
      },
      -- LSP driven completions
      'hrsh7th/cmp-nvim-lsp',
      -- completion from buffer text
      'hrsh7th/cmp-buffer',
      -- file path completion
      'hrsh7th/cmp-path',
      -- command line completion
      'hrsh7th/cmp-cmdline',
      -- neovim lua config api completion
      'hrsh7th/cmp-nvim-lua',
      -- emoji completion (triggered by `:`)
      'hrsh7th/cmp-emoji',
      -- snippets in completion sources
      'saadparwaiz1/cmp_luasnip',
      -- git completions
      'petertriho/cmp-git',
      -- tmux pane completion
      'andersevenrud/cmp-tmux',
      -- icons for the completion menu
      'onsails/lspkind.nvim',
    },
    config = function()
      require('plugins.cmp').setup()
    end,
  },

  -- installs/updates LSPs, linters and DAPs
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- handles connection of LSP Configs and Mason
      'williamboman/mason-lspconfig.nvim',

      -- Collection of configurations for the built-in LSP client
      'neovim/nvim-lspconfig',

      -- required for setting up capabilities for cmp
      'hrsh7th/cmp-nvim-lsp',

      {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
      },

      -- elixir commands from elixirls
      {
        'elixir-tools/elixir-tools.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim' },
      },
    },
    config = function()
      require('plugins.lsp').setup()
    end,
  },

  -- LSP UI utils
  {
    'glepnir/lspsaga.nvim',
    event = 'VeryLazy',
    branch = 'main',
    config = function()
      require('core.mappings').lsp_saga_mappings()
    end,
    opts = require 'plugins.lspsaga',
  },

  -- LSP Output Panel
  {
    'mhanberg/output-panel.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- automatically install tools using mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = require 'plugins.mason-tool-installer',
  },

  -- Neovim as a language server to inject LSP diagnostics, code
  -- actions, and more via Lua.
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',

      'lukas-reineke/lsp-format.nvim',
    },
    config = function()
      require('plugins.null-ls').setup()
    end,
  },

  -- like leap, but with tiny hops
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    keys = core_mappings.hop_mappings,
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
  },

  --  pretty diagnostics, references, telescope results, quickfix and location
  --  list to help you solve all the trouble your code is causing.
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = core_mappings.trouble_mappings,
    opts = {},
  },

  -- modern vim command line replacement, requires nvim 0.9 or higher
  {
    'folke/noice.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  -- color schemes
  ----------------
  {
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('tokyonight').setup {
        style = 'storm',
        transparent = true,
      }

      vim.cmd [[colorscheme tokyonight]]
    end,
  },

  -- highlight color hex codes with their color (fast!)
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      '*',
      '!lazy',
    },
  },

  -- highlight and search todo/fixme/hack etc comments
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.lualine').setup()
    end,
  },

  -- Visual git gutter (also used by feline)
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = require 'plugins.gitsigns',
  },

  -- syntax highlighting for zinit (zsh plugin manager)
  { 'zdharma-continuum/zinit-vim-syntax', ft = { 'zsh' } },

  -- Comment out code easily
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('plugins.comment').setup()
    end,
  },

  -- delete unused buffers
  { 'schickling/vim-bufonly', cmd = 'BO' },

  -- nginx syntax support
  'chr4/nginx.vim',

  -- run tests at the speed of thought
  {
    'janko-m/vim-test',
    keys = core_mappings.vim_test_mappings,
    dependencies = { 'benmills/vimux' },
    init = function()
      vim.g['test#strategy'] = 'vimux'
      -- accommodations for Malomo's unusual folder structure on Dash
      vim.cmd [[let test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|__tests__))\.(js|jsx|coffee|ts|tsx)$']]
    end,
  },

  -- git integration
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      core_mappings.fugitive_mappings()
    end,
  },

  -- github support for fugitive
  {
    'tpope/vim-rhubarb',
    event = 'VeryLazy',
    dependencies = { 'tpope/vim-fugitive' },
  },

  --  Better syntax highlighting (and more)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'RRethy/nvim-treesitter-endwise',
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('plugins.treesitter').setup()
    end,
  },

  -- play with TreeShitter
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    dependencies = {

      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- support for MJML templates
  'amadeus/vim-mjml',

  -- auto complete closable pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- auto close html/tsx tags using TreeSitter
  -- TODO: add ft lazy loading
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },

  -- file tree
  {
    'nvim-tree/nvim-tree.lua',
    keys = core_mappings.nvim_tree_mappings,
    cmd = 'NvimTreeToggle',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = require 'plugins.nvimtree',
  },

  -- growing collection of settings, commands and mappings put together to make
  -- working with the location list/window and the quickfix list/window smoother
  { 'romainl/vim-qf', event = 'VeryLazy' },

  -- Simple plugin for placing signs in buffer's gutter next to lines that appear in the QuickFix results.
  { 'matthias-margush/qfx.vim', event = 'VeryLazy' },

  -- navigate to directory of current file using `-`
  'tpope/vim-vinegar',

  -- automatically adjusts 'shiftwidth' and 'expandtab' heuristically
  'tpope/vim-sleuth',

  -- ruby gem info directly in a Gemfile
  { 'alexbel/vim-rubygems', ft = { 'ruby' } },

  -- Elixir: {{{

  -- pulls info on hex packages (dependencies mattn/webapi-vim)
  { 'lucidstack/hex.vim', ft = { 'elixir' }, dependencies = { 'mattn/webapi-vim' } },
  -- }}},

  -- add text object for HTML attributes - allows dax cix etc
  {
    'whatyouhide/vim-textobj-xmlattr',
    event = 'VeryLazy',
    ft = { 'html' },
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- graphql support
  'jparise/vim-graphql',

  -- Vim sugar for the UNIX shell commands that need it the most.
  -- TODO: add cmd lazy loading
  { 'tpope/vim-eunuch', event = 'VeryLazy' },

  -- allow (non-native) plugins to the . command
  { 'tpope/vim-repeat', event = 'VeryLazy' },

  -- Surround text with closures
  { 'tpope/vim-surround', event = 'VeryLazy' },

  -- vim projectionist allows creating :Esomething custom shortcuts (required by vim rake)
  {
    'tpope/vim-projectionist',
    config = function()
      require('plugins.projectionist').setup()
    end,
  },

  -- vim unimpaired fixes daily annoyances
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },

  -- abolish.vim: easily search for, substitute, and abbreviate multiple variants
  -- of a word
  { 'tpope/vim-abolish', event = 'VeryLazy' },

  -- Support emacs keybindings in insert mode
  { 'tpope/vim-rsi', event = 'VeryLazy' },

  -- RagTag: Auto-close html tags + mappings for template scripting languages
  -- TODO: add ft lazy loading
  { 'tpope/vim-ragtag', event = 'VeryLazy' },

  -- smarter gx mapping
  {
    'chrishrb/gx.nvim',
    keys = { 'gx' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- automatic bulleted lists
  {
    'dkarter/bullets.vim',
    init = function()
      vim.g.bullets_enabled_file_types = {
        'markdown',
        'text',
        'gitcommit',
        'scratch',
      }
    end,
    ft = {
      'markdown',
      'text',
      'gitcommit',
      'scratch',
    },
  },

  -- replacement for matchit
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    init = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
  },

  -- window animations
  { 'camspiers/animate.vim', event = 'VeryLazy' },

  -- show trailing white spaces and automatically delete them on write
  {
    'zakharykaplan/nvim-retrail',
    config = function()
      require('plugins.retrail').setup()
    end,
  },

  -- Convert code to multiline
  {
    'AndrewRadev/splitjoin.vim',
    event = 'VeryLazy',
    init = function()
      vim.g.splitjoin_align = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_ruby_curly_braces = 0
      vim.g.splitjoin_ruby_hanging_args = 0
    end,
  },

  -- Toggle between different language verbs or syntax styles
  {
    'AndrewRadev/switch.vim',
    init = function()
      vim.g.switch_custom_definitions = {
        { 'up', 'down', 'change' },
        { 'add', 'drop', 'remove' },
        { 'create', 'drop' },
        { 'row', 'column' },
        { 'first', 'second', 'third', 'fourth', 'fifth' },
        { 'yes', 'no' },
      }
    end,
  },

  -- The ultimate undo history visualizer for VIM
  {
    'mbbill/undotree',
    keys = core_mappings.undotree_mappings,
  },

  --  Indent lines (visual indication)
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent_blankline').setup()
    end,
  },

  -- smooth scrolling in neovim
  {
    'declancm/cinnamon.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- fuzzy find things
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-github.nvim',
      'olacin/telescope-cc.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'm-demare/attempt.nvim',
      'folke/tokyonight.nvim',
    },
    config = function()
      require('plugins.telescope').setup()
    end,
  },

  -- better ui for vim.ui commands
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- RipGrep - grep is dead. All hail the new king RipGrep.
  {
    'jremmen/vim-ripgrep',
    event = 'VeryLazy',
    init = function()
      -- allow hidden files to be searched and smart case
      vim.g.rg_command = 'rg --vimgrep --hidden --smart-case'
      vim.g.rg_highlight = 1
    end,
    config = function()
      core_mappings.ripgrep_mappings()
    end,
  },

  -- displays a popup with possible key bindings e.g. <leader>f will show f as
  -- the next possible character
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- same as tabular but by Junegunn and way easier
  -- TODO: add command and mapping lazy loading
  {
    'junegunn/vim-easy-align',
    config = function()
      core_mappings.easy_align_mappings()
    end,
  },

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- manage github gists
  { 'mattn/gist-vim', cmd = 'Gist', dependencies = { 'mattn/webapi-vim' } },

  -- PostgreSQL highlighting
  'exu/pgsql.vim',

  -- Helm Chart syntax
  'towolf/vim-helm',

  -- attempt stuff using scratch buffer and pre-configured bootstrap
  {
    'm-demare/attempt.nvim',
    keys = core_mappings.attempt_mappings,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = require 'plugins.attempt',
  },

  --- TMUX ---

  -- tmux config file stuff
  { 'tmux-plugins/vim-tmux', ft = 'tmux' },

  -- seamless tmux/vim pane navigation
  'christoomey/vim-tmux-navigator',

  -- Resize tmux panes and Vim windows with ease.
  'RyanMillerC/better-vim-tmux-resizer',

  -- support editorconfig files
  'gpanders/editorconfig.nvim',

  -- notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require 'notify'
      notify.setup {
        background_colour = '#000',
      }
      vim.notify = notify

      core_mappings.notify_mappings()
    end,
  },
}, { concurrency = 8 })
