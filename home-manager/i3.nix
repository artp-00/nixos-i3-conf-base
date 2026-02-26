# https://github.com/srid/nix-config/blob/705a70c094da53aa50cf560179b973529617eb31/nix/home/i3.nix
{ config, lib, pkgs, ... }:

let
    mod = "Mod4";
in {
    xsession.windowManager.i3 = {
        enable = true;
        config = {

            terminal = "kitty";
            modifier = mod;
            menu = "rofi -show drun -display-drun ' 󰨊 '";
            # menu = "ulauncher-toggle";
            defaultWorkspace = "1";
            focus = {
                followMouse = false;
            };
            fonts = {
                names = [
                    "DejaVu Sans Mono, FontAwesome"
                ];
                size = 10.0;
            };
            gaps = {
                inner = 5;
                outer = 0;

                smartGaps = true;
            };
            window = {
                hideEdgeBorders = "smart";
                border = 0;
                titlebar = false;
            };
            keybindings = lib.mkOptionDefault {
                # "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
                "${mod}+Shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui";
                "${mod}+Shift+g" = "exec ${pkgs.i3lock}/bin/i3lock"; # TODO: i3lock config

                # Focus
                "${mod}+j" = "focus left";
                "${mod}+k" = "focus down";
                "${mod}+l" = "focus up";
                "${mod}+semicolon" = "focus right";

                # Move
                "${mod}+Shift+j" = "move left";
                "${mod}+Shift+k" = "move down";
                "${mod}+Shift+l" = "move up";
                "${mod}+Shift+semicolon" = "move right";

                # shutdown menu
                "${mod}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show menu -modi 'menu:rofi-power-menu --choices=shutdown/reboot/logout'";
                # file browser
                "${mod}+Shift+f" = "exec ${pkgs.rofi}/bin/rofi -show filebrowser -display-filebrowser ' 󱧶 '";
                # lights
                "${mod}+F2" = "exec brightnessctl set '10%-'";
                "${mod}+F3" = "exec brightnessctl set '+10%'";
            };

            startup = [
                { command = "autotiling-rs"; always = true; }
                # { command = "ulauncher --hide-window"; always = true; }
                { command = "i3-rounded"; always = true; }
                { command = "i3-msg workspace 1"; always = true; notification = false; }
            ];
            colors = {

            };
        };
        extraConfig = ''
            for_window [class="^.*"] border pixel 0";
        '';
    };
    # BAR
    xsession.windowManager.i3.config.bars = [
        {
            position = "bottom";
            mode = "hide";
            hiddenState = "hide";
            statusCommand = "${pkgs.i3status}/bin/i3status";
            trayOutput = "primary";
            fonts = {
                names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
                size = 10.0;
            };
            colors = {
                background = "#282828";
                statusline = "#ebdbb2";
                separator = "#666666";
                focusedWorkspace = {
                    border = "#83a598";
                    background = "#458588";
                    text = "#ebdbb2";
                };
                activeWorkspace = {
                    border = "#3c3836";
                    background = "#504945";
                    text = "#ebdbb2";
                };
                inactiveWorkspace = {
                    border = "#3c3836";
                    background = "#3c3836";
                    text = "#928374";
                };
            };
        }
    ];
}
