{ config, lib, pkgs, ... }:

{
    programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
        vim-airline
        fzf-vim
        vim-trailing-whitespace
        # vim_current_word
        vim-surround
        nerdtree
        vim-gitgutter
        vim-commentary
        auto-pairs
        vim-airline-themes
    ];
    settings = {
        ignorecase = true;
    };
    extraConfig = ''
        set mouse=a
        set number
        syntax on
        set ruler
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        :let mapleader = " "

        let g:airline#extensions#tabline#enabled = 1

        nnoremap <C-t> :NERDTreeFocus<CR>
        nnoremap <C-b> :NERDTreeToggle<CR>

        autocmd VimEnter * AirlineTheme atomic
        autocmd VimEnter * colors base16-stylix

        nnoremap <Leader>ff :Files<CR>
        nnoremap <Leader>fg :Rg<CR>
    '';
    # nnoremap <C-n> :NERDTree<CR>
    # nnoremap <C-f> :NERDTreeFind<CR>
  };
}
