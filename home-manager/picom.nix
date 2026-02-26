{ config, lib, pkgs, ... }:

{
    services.picom = {
        enable = true;
        activeOpacity = 1.0;
        fade = true;
        fadeDelta = 2;
        inactiveOpacity = 0.8;
        extraArgs = [
            "--corner-radius" "15"
        ];
    };
}
