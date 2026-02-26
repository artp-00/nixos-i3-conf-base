{ config, lib, pkgs, ... }:

{
    programs.librewolf = {
        enable = true;
        settings = {
            "webgl.disabled" = false;
            "privacy.resistFingerprinting" = false;
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.cookies" = false;
            "network.cookie.lifetimePolicy" = 0;
            "extensions.activeThemeID" = "{c0f86627-5243-4bf4-a522-a41ed12f1737}";
        };
        profiles.YOUR_USERNAME = {
            name = "YOUR_USERNAME";
            isDefault = true;
        };
        policies = {
            ExtensionSettings = {
                # Privacy Badger
                "jid1-MnnxcxisBPnSXQ@jetpack" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4321653/privacy_badger17-latest.xpi";
                    installation_mode = "force_installed";
                    default_area = "menupanel";
                };
                # uBlock Origin:
                "uBlock0@raymondhill.net" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                    installation_mode = "force_installed";
                    default_area = "navbar";
                };
                # Vimium
                "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
                    installation_mode = "force_installed";
                    default_area = "menupanel";
                };
                # everforest theme
                "{c0f86627-5243-4bf4-a522-a41ed12f1737}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/file/4055905/everforest_dark_official-2.0.xpi";
                    installation_mode = "force_installed";
                    default_area = "menupanel";
                };
            };
        };
    };
}
