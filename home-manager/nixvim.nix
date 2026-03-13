# https://nix-community.github.io/nixvim/
{ inputs, config, lib, pkgs, ... }:

let
    get_bufnrs.__raw = ''
    function()
        local buf_size_limit = 1024 * 1024 -- 1MB size limit
        local bufs = vim.api.nvim_list_bufs()
            local valid_bufs = {}
            for _, buf in ipairs(bufs) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf)) < buf_size_limit then
                    table.insert(valid_bufs, buf)
                end
            end
            return valid_bufs
        end
    '';
in
{
    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        opts = {
            number = true;
            relativenumber = false;
            shiftwidth = 4;
            tabstop = 2;            # Tab width
            expandtab = true;
            undofile = true;
        };

        globals = {
            mapleader = " ";
        };

        plugins = {
            lsp = {
                enable = true;
                servers = {
                    # nix
                    nil_ls.enable = true;
                    # lua
                    lua_ls.enable = true;
                    # sh
                    bashls.enable = true;
                    # C/C++
                    clangd.enable = true;
                    # js
                    denols.enable = true;
                    # docker
                    dockerls.enable = true;
                    docker_compose_language_service = {
                        enable = true;
                        settings = {
                            filetypes = [".yml"];
                        };
                    };
                    # java
                    java_language_server.enable = true;
                    # python
                    ruff.enable = true;
                };
            };

            cmp = {
                enable = true;
                autoEnableSources = true;
                settings.mapping = {
                    "<Tab>" = "cmp.mapping.confirm({ select = true })";
                    "<Down>" = ''
                        cmp.mapping(cmp.mapping.select_next_item({
                          behavior = cmp.SelectBehavior.Select
                        }), {'i', 'c'})
                    '';
                    "<Up>" = ''
                        cmp.mapping(cmp.mapping.select_prev_item({
                          behavior = cmp.SelectBehavior.Select
                        }), {'i', 'c'})
                    '';
                };
                settings.sources = [
                {
                    name = "nvim_lsp";
                    priority = 1000;
                    option = {
                        inherit get_bufnrs;
                    };
                }
                {
                    name = "nvim_lsp_signature_help";
                    priority = 1000;
                    option = {
                      inherit get_bufnrs;
                    };
                }
                {
                    name = "treesitter";
                    priority = 850;
                    option = {
                        inherit get_bufnrs;
                    };
                }
                {
                    name = "buffer";
                    priority = 500;
                    option = {
                        inherit get_bufnrs;
                    };
                }
                {
                    name = "path";
                    priority = 300;
                }
                ];
            };

            scrollview.enable = true;
            noice.enable = true;

            lsp-lines.enable = true;
            lualine = {
                enable = true;
                # bubble theme for lualine
                settings = {
                    options = {
                        component_separators = "";
                        section_separators = {
                            left = "";
                            right = "";
                        };

                    };

                    sections = {
                        lualine_a = [
                        {
                            __unkeyed-1 = "mode";
                            # separator = { left = "";};
                            separator = { left = ""; right = ""; };
                            right_padding = 2;
                        }
                        ];
                        lualine_b = [ "filename" "branch" ];
                        lualine_c = [ "%=" ];
                        lualine_x = [ ];
                        lualine_y = [ "filetype" "progress" ];
                        lualine_z = [
                        {
                            __unkeyed-1 = "location";
                            # separator = { right = ""; };
                            separator = { left = ""; right = ""; };
                            left_padding = 2;
                        }
                        ];
                    };

                    inactive_sections = {
                        lualine_a = [ "filename" ];
                        lualine_b = [ ];
                        lualine_c = [ ];
                        lualine_x = [ ];
                        lualine_y = [ ];
                        lualine_z = [ "location" ];
                    };
                };
            };

            # TODO: tab bindings
            gitblame.enable = true;
            treesitter-context = {
                enable = true;
                settings.max_lines = 2;
            };
            gitsigns.enable = true;
            visual-multi.enable = true;
            fastaction.enable = true;
            nvim-autopairs.enable = true;
            undotree.enable = true;
            comment.enable = true;
            nvim-surround.enable = true;
            mini-ai.enable = true;
            todo-comments.enable = true;
            render-markdown.enable = true;
            web-devicons.enable = true;

            neo-tree = {
                enable = true;
                settings = {
                    close_if_last_window = true;
                    enableDiagnostics = true;
                    enableGitStatus = true;
                    enableModifiedMarkers = true;
                    enableRefreshOnWrite = true;
                    popupBorderStyle = "rounded";
                };
            };

            telescope = {
                enable = true;
                keymaps = {
                    "<leader>fg" = "live_grep";
                    "<leader>ff" = "find_files";
                };
            };

            harpoon = {
                enable = true;
            };
            illuminate = {
                enable = true;
                settings = {
                    under_cursor = true;
                    filetypes_denylist = [
                        "Outline"
                        "TelescopePrompt"
                        "alpha"
                        "harpoon"
                        "reason"
                    ];
                };
            };

            treesitter = {
                enable = true;
                folding = false;
                grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                  bash
                  json
                  lua
                  make
                  markdown
                  nix
                  regex
                  toml
                  vim
                  vimdoc
                  xml
                  yaml
                  python
                  c
                  rust
                  go
                ];
            };
        };

        extraPlugins = [
            pkgs.vimPlugins.tabby-nvim
        ];

        keymaps = [
            # TODO: 
            # NEO TREE BINDINGS
            {
                action = "<cmd>Neotree focus<CR>";
                key = "<C-t>";
            }
            {
                action = "<cmd>Neotree toggle<CR>";
                key = "<C-b>";
            }
            {
                action = "<cmd>lua require'lsp_lines'.toggle()<CR>";
                key = "<leader>l";
            }
            {
                action = "<cmd>lua require'fastaction'.code_action()<CR>";
                key = "<A-CR>";
            }
        ];
        extraConfigVim = ''
            set so=10
        '';
        extraConfigLua = ''
            require"tabby".setup()
        '';
        extraConfigLuaPost = ''
            vim.cmd([[hi SignColumn guibg=bg]])
            vim.cmd([[hi LineNr guibg=bg]])
        '';
    };
}
