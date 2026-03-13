# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  nixvim,
  ...
}: {
  imports = [
    ./i3.nix
    ./code.nix
    ./zsh.nix
    ./librewolf.nix
    ./kitty.nix
    ./picom.nix
    ./rofi.nix
    ./vim.nix
    ./btop.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "YOUR_USERNAME";
    homeDirectory = "/home/YOUR_USERNAME";
  };
  stylix.targets.librewolf.profileNames = ["YOUR_USERNAME"];

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
      vscode
      gimp

      lua
      uv
      go
      rustc

      qemu
      arandr
      rofi-power-menu
      quickemu
      discord
      libreoffice
      steam
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # NOTE: terminal emulator alternative
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
        custom-shader = "/etc/nixos/home-manager/resources/ghostty_shader.glsl";
        window-padding-x = 10;
        window-padding-y = 10;
        window-decoration = "none";
    };
  };

  # ==== non nix dotfiles ====
  # dunst
  xdg.configFile."dunst/dunstrc".source = ./resources/dunstrc;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
