{ config, lib, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ls = "eza";
            la = "ls -la";
            v = "nvim";
            q = "exit";

            # scripts
            update = "${./../scripts/nix-update.sh}";
            setlight = "${./../scripts/setlight.sh}";
            gtag = "${./../scripts/gtag.sh}";
        };
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "vi-mode" "fzf" ];
            theme = "arrow";
        };
        initContent = ''
            bindkey '^H' backward-kill-word
            bindkey '^[[3;5~' kill-word
        '';
        sessionVariables = {
            KEYTIMEOUT = 1;
        };
    };
}
