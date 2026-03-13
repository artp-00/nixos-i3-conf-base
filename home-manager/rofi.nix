
{ config, lib, pkgs, ... }:

{
    programs.rofi = {
        enable = true;
        modes = [ "drun" "filebrowser" ];
        extraConfig = {
            show-icons = true;
            font = "Droid Sans Mono 16";
            element-icon = "2ch";
        };
        theme = lib.mkMerge [
            {
                window.padding = 10;
                mainbox.spacing = 0;
                listview = {
                    spacing = 10;
                    padding = 8;
                    border-radius = 5;
                };
                element = {
                    padding = 3;
                    border-radius = 5;
                };
            }
        ];
    };
}
