{ config, lib, pkgs, ... }:

{
    programs.kitty = lib.mkForce {
        enable = true;
        settings = {
            shell = "zsh";
            confirm_os_window_close = 0;
            dynamic_background_opacity = true;
            enable_audio_bell = false;
            mouse_hide_wait = "-1.0";
            window_padding_width = 10;
            scrollback_lines = 10000;

            cursor_trail = 1;
            cursor = "#ff0000"; # TODO: make it work
        };
    };
}
