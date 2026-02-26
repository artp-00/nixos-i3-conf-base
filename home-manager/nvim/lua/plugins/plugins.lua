return
{
     -------------- LSP PLUGINS -------------- 

    { "williamboman/mason.nvim", opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = {},
        dependencies = {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        }
    },
    -- LSP servers and clients communicate which features they support through "capabilities".
    --  By default, Neovim supports a subset of the LSP specification.
    --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
    --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
    --
    -- This can vary by config, but in general for nvim-lspconfig
    -- {
    --     'neovim/nvim-lspconfig',
    --     dependencies = { 'saghen/blink.cmp' },
    --
    --     -- example using `opts` for defining servers
    --     opts = {
    --         servers = {
    --             lua_ls = {}
    --         }
    --     },
    -- },
    -- {
    --     'Chaitanyabsprip/fastaction.nvim',
    --     opts = {},
    -- },
    -- {
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"},

            -- optional picker via telescope
            {"nvim-telescope/telescope.nvim"},
        },
        event = "LspAttach",
        opts = {
            picker = "telescope",
        },
    },
    {"ThePrimeagen/harpoon", branch="harpoon2"},
    {
      "benomahony/uv.nvim",
      -- Optional filetype to lazy load when you open a python file
      -- ft = { python }
      -- Optional dependency, but recommended:
      -- dependencies = {
      --   "folke/snacks.nvim"
      -- or
      --   "nvim-telescope/telescope.nvim"
      -- },
      opts = {
        picker_integration = true,
      },
    },
    {
        "microsoft/python-type-stubs",
        cond = false
    },
    {"mfussenegger/nvim-dap"},
    {"mfussenegger/nvim-dap-python"},
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },
    {"folke/lazydev.nvim"},
        {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "InsertEnter",
    --   opts = {
    --     bind = true,
    --     handler_opts = {
    --       border = "rounded"
    --     }
    --   },
    --   -- or use config
    --   -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
    -- },

    -------------- AUTOCOMPLETION -------------- 

    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'super-tab' },

            signature = { enabled = false },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- default = { 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },

    -------------- NAVIGATION -------------- 

    { "nvim-telescope/telescope.nvim", opts = {} },
    { "nvim-tree/nvim-tree.lua", opts = {} },
    { "echasnovski/mini.ai", opts = {} },

    -------------- COLORSCHEME -------------- 

    { "nvim-treesitter/nvim-treesitter", opts = {} },
    { "sainnhe/everforest" },
    { "gbprod/nord.nvim", opts = {} },
    { "vague2k/vague.nvim", opts = {} },
    { "sho-87/kanagawa-paper.nvim", opts = {} },
    { "chama-chomo/grail", opts = {} },

    -------------- UTILITY -------------- 

    { "kylechui/nvim-surround", opts = {} },
    { "numToStr/Comment.nvim", opts = {} },
    { "mbbill/undotree" },
    -- { "m4xshen/autoclose.nvim", opts = {} },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
        opts = {
        },
    },
    { "ziontee113/color-picker.nvim", opts = {} },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      },
    },

    -------------- VISUALS -------------- 

    {'lewis6991/gitsigns.nvim'},
    { "sontungexpt/stcursorword", opts = {} },
    {'nvim-tree/nvim-web-devicons'},
    {'nanozuki/tabby.nvim'},
    -- {
    --     'nvim-lualine/lualine.nvim',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' }
    -- },
    {
        'beauwilliams/statusline.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-lua/lsp-status.nvim' }
    },
    {'nvim-treesitter/nvim-treesitter-context'},
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true,  -- if you want to enable the plugin
            message_template = " <date> • <author>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y", -- template for the date, check Date format section for more options
            virtual_text_column = 2,  -- virtual text start column, check Start virtual text at column section for more options
        },
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
        -- {
          cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {}, -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
              -- conceal:: (default is cmdline view)
              -- opts: any options passed to the view
              -- icon_hl_group: optional hl_group for the icon
              -- title: set to anything or empty string to hide
              cmdline = { view = "cmdline" },
              search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
              search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
              filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
              lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
              help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
              input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
              -- lua = false, -- to disable a format, set to `false`
            },
          },
          messages = {
            enabled = false, -- enables the Noice messages UI
          },
          popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "nui", -- backend to use to show regular cmdline completions
            ---@type NoicePopupmenuItemKind|false
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = {}, -- set to `false` to disable icons
          },
          -- default options for require('noice').redirect
          -- see the section on Command Redirection
          ---@type NoiceRouteConfig
          redirect = {
            view = "popup",
            filter = { event = "msg_show" },
          },
          -- You can add any custom commands below that will be available with `:Noice command`
          ---@type table<string, NoiceCommand>
          commands = {
            history = {
              -- options for the message history that you get with `:Noice`
              view = "split",
              filter_opts = {},
              opts = { enter = true, format = "details" },
              filter = {
                any = {
                  { event = "notify" },
                  { error = true },
                  { warning = true },
                  { event = "msg_show", kind = { "" } },
                  { event = "lsp", kind = "message" },
                },
              },
            },
            -- :Noice last
            last = {
              view = "popup",
              opts = { enter = true, format = "details" },
              filter = {
                any = {
                  { event = "notify" },
                  { error = true },
                  { warning = true },
                  { event = "msg_show", kind = { "" } },
                  { event = "lsp", kind = "message" },
                },
              },
              filter_opts = { count = 1 },
            },
            -- :Noice errors
            errors = {
              -- options for the message history that you get with `:Noice`
              view = "popup",
              opts = { enter = true, format = "details" },
              filter = { error = true },
              filter_opts = { reverse = true },
            },
            all = {
              -- options for the message history that you get with `:Noice`
              view = "split",
              opts = { enter = true, format = "details" },
              filter = {},
              filter_opts = {},
            },
          },
          notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = true,
            view = "notify",
          },
          lsp = {
            progress = {
              enabled = true,
              -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
              -- See the section on formatting for more details on how to customize.
              --- @type NoiceFormat|string
              format = "lsp_progress",
              --- @type NoiceFormat|string
              format_done = "lsp_progress_done",
              throttle = 1000 / 30, -- frequency to update lsp progress message
              view = "mini",
            },
            override = {
              -- override the default lsp markdown formatter with Noice
              ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
              -- override the lsp markdown formatter with Noice
              ["vim.lsp.util.stylize_markdown"] = false,
              -- override cmp documentation with Noice (needs the other options to work)
              ["cmp.entry.get_documentation"] = false,
            },
            hover = {
              enabled = true,
              silent = false, -- set to true to not show a message if hover is not available
              view = nil, -- when nil, use defaults from documentation
              ---@type NoiceViewOptions
              opts = {}, -- merged with defaults from documentation
            },
            signature = {
              enabled = true,
              auto_open = {
                enabled = true,
                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50, -- Debounce lsp signature help request by 50ms
              },
              view = nil, -- when nil, use defaults from documentation
              ---@type NoiceViewOptions
              opts = {}, -- merged with defaults from documentation
            },
            message = {
              -- Messages shown by lsp servers
              enabled = true,
              view = "notify",
              opts = {},
            },
            -- defaults for hover and signature help
            documentation = {
              view = "hover",
              ---@type NoiceViewOptions
              opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
              },
            },
          },
          markdown = {
            hover = {
              ["|(%S-)|"] = vim.cmd.help, -- vim help links
	      -- ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
            },
            highlights = {
              ["|%S-|"] = "@text.reference",
              ["@%S+"] = "@parameter",
              ["^%s*(Parameters:)"] = "@text.title",
              ["^%s*(Return:)"] = "@text.title",
              ["^%s*(See also:)"] = "@text.title",
              ["{%S-}"] = "@parameter",
            },
          },
          health = {
            checker = true, -- Disable if you don't want health checks to run
          },
          ---@type NoicePresets
          presets = {
            -- you can enable a preset by setting it to true, or a table that will override the preset config
            -- you can also add custom presets that you can enable/disable with enabled=true
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
          throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
          ---@type NoiceConfigViews
          views = {}, ---@see section on views
          ---@type NoiceRouteConfig[]
          routes = {}, --- @see section on routes
          ---@type table<string, NoiceFilter>
          status = {}, --- @see section on statusline components
          ---@type NoiceFormatOptions
          format = {}, --- @see section on formatting
        },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    },
    {"dstein64/nvim-scrollview"},
    -- {
    --     "mg979/vim-visual-multi",
    --     lazy = false,
    -- },
    -------------- DASHBOARD -------------- 

    {
        'goolord/alpha-nvim',
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            require'alpha'.setup(require'themes.theta_custom'.config)
        end
    },
    {"typicode/bg.nvim"},
    {"yuukiflow/Arduino-Nvim"},
}
