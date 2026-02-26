vim.cmd([[set termguicolors]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")

---------- TABS ----------
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character

vim.o.list = true
vim.o.listchars = 'tab:» ,lead: ,trail:•'

---------- PERSISTENT UNDO ----------
vim.o.undofile = true

---------- LINE NUMBER ----------
vim.wo.number = true
vim.opt.signcolumn = 'yes'
-- vim.wo.relativenumber = true

---------- COLORSCHEME ----------
-- vim.cmd([[colorscheme grail]])
-- vim.cmd([[colorscheme nord]])
vim.cmd([[colorscheme everforest]])
-- vim.cmd([[colorscheme kanagawa-paper]])

---------- SETTINGS ----------
-- vim.cmd([[set cc=80]]) -- vertical line at 80 characters
vim.cmd([[set so=6]]) -- cursor padding
vim.cmd([[set ut=500]])

---------- NVIM TREE ----------

vim.keymap.set("n", "<C-t>", function()
  require("nvim-tree.api").tree.open({ find_file = true, focus = true })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", function()
  require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
end, { noremap = true, silent = true })

---------- UNDO TREE ----------
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

---------- TELESCOPE ----------
require("telescope").setup {
    pickers = {
        find_files = {
            hidden = true,
        }
    },
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git",
        }
    }
}
require("telescope").load_extension('noice')
require("telescope").load_extension('harpoon')

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-p>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.signatureHelp = nil

-- vim.lsp.enable('pyright')
-- vim.lsp.config('pyright', {
--     capabilities = capabilities,
--     -- on_attach = function(client, bufnr)
--     --     client.server_capabilities.signatureHelpProvider = nil
--     -- end,
--     -- on_attach = function(client, bufnr)
--     --     require'lsp_signature'.on_attach({}, bufnr)
--     -- end,

--     cmd = { "pyright-langserver", "--stdio" },
--     filetypes = { "python" },
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 typeCheckingMode = "off",
--                 diagnosticMode = 'openFilesOnly',
--             }
--         }
--     }
-- })

-- vim.lsp.enable('ruff')
-- vim.lsp.config('ruff', {
--     filetypes = { "python" },
--     init_options = {
--         settings = {
--             -- Any extra CLI arguments for `ruff` go here.
--             args = {
--             },
--         }
--     }
-- })

vim.lsp.enable('typescript-language-server')
vim.lsp.config("ts_ls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = os.getenv("HOME") .. "/.local/share/nvm/v23.1.0/lib/node_modules/@vue/typescript-plugin",
              languages = { "vue" },
            },
          },
        },
        root_markers = {'.git', 'package.json'},
        cmd = { "typescript-language-server", "--stdio" },
      })


vim.lsp.enable('rnix')
vim.lsp.config['rnix'] = {
  -- cmd = { 'lua-language-server' },
  filetypes = { 'nix' },
  root_markers = { '.git' },
  settings = {},
}

vim.lsp.enable('arduino')
vim.lsp.config['arduino'] = {
  -- cmd = { 'lua-language-server' },
  filetypes = { 'ino' },
  settings = {},
}


vim.lsp.enable('lua_ls')
vim.lsp.config['lua_ls'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}

vim.lsp.enable('bashls')
vim.lsp.config['bashls'] = {
  -- Filetypes to automatically attach to.
  filetypes = { 'bash', 'sh' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { '.git' },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
  }
}



-- require("dap-python").setup("uv")
local dap = require('dap')
dap.adapters.python = function(cb, config)
  -- if config.request == 'attach' then
  --   ---@diagnostic disable-next-line: undefined-field
  --   local port = (config.connect or config).port
  --   ---@diagnostic disable-next-line: undefined-field
  --   local host = (config.connect or config).host or '127.0.0.1'
  --   cb({
  --     type = 'server',
  --     port = assert(port, '`connect.port` is required for a python `attach` configuration'),
  --     host = host,
  --     options = {
  --       source_filetype = 'python',
  --     },
  --   })
  -- else
    cb({
      type = 'executable',
      command = '/snap/bin/uv',
      args = { 'run', 'eveler', 'dev_server' },
      options = {
        source_filetype = 'python',
      },
    })
  -- end
end
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}



require("lazydev").setup({
  library = { "nvim-dap-ui" },
})
require("dapui").setup()
vim.keymap.set('n', '<leader>d', require("dapui").toggle, {})
vim.keymap.set('n', '<leader>b', require'dap'.toggle_breakpoint, {})

-- vim.keymap.set('n', '<A-CR>', require("fastaction").code_action, {})
vim.keymap.set({ "n", "x" }, "<A-CR>", function()
	require("tiny-code-action").code_action({})
end, { noremap = true, silent = true })

vim.diagnostic.config {
    underline = true,
    virtual_text = {
        prefix = "",
        severity = nil,
        source = "if_many",
        format = nil,
    },
    signs = true,
    severity_sort = true,
    update_in_insert = false,
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- require('lualine').setup({})

---------- TREESITTER ----------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },
  modules = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a functionunction for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- modules = {},
}



local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}
require('tabby').setup({
  line = function(line)
    return {
      {
        { '  ', hl = theme.head },
        line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep('', hl, theme.fill),
          tab.is_current() and '' or '󰆣',
          tab.number(),
          tab.name(),
          tab.close_btn(''),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep('', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep('', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      {
        line.sep('', theme.tail, theme.fill),
        { '  ', hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})

vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":tabp<CR>", { noremap = true })

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 10, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

require("luasnip").config.setup({ enable_autosnippets = true })

require('statusline').setup({
    match_colorscheme = true, -- Enable colorscheme inheritance (Default: false)
    tabline = true, -- Enable the tabline (Default: true)
    lsp_diagnostics = true, -- Enable Native LSP diagnostics (Default: true)
    ale_diagnostics = false, -- Enable ALE diagnostics (Default: false)
})
