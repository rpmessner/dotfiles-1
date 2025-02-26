local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if not present then
  return
end

local M = {}

M.setup = function()
  vim.cmd [[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    " disable folds at startup
    set nofoldenable
  ]]

  treesitter.setup {
    -- see full list here:
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    ensure_installed = {
      'arduino',
      'bash',
      'c',
      'cmake',
      'comment',
      'cpp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'eex',
      'elixir',
      'elm',
      'erlang',
      'gitcommit',
      'git_rebase',
      'gitignore',
      'gleam',
      'go',
      'graphql',
      'haskell',
      'heex',
      'hjson',
      'html',
      'http',
      'java',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'jsonc',
      'llvm',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'ruby',
      'rust',
      'scss',
      'sql',
      'surface',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
      'zig',
    },
    autotag = { enable = true },
    highlight = { enable = true },
    indent = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ip'] = '@parameter.inner',
          ['ap'] = '@parameter.outer',
          ['ib'] = '@block.inner',
          ['ab'] = '@block.outer',
          ['ik'] = '@comment.inner',
          ['ak'] = '@comment.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>pn'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>pp'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        -- whether to set jumps in the jumplist
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },
    -- :TSPlaygroundToggle
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'gq',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
    endwise = {
      enable = true,
    },
  }
end

return M
