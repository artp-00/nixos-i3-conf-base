# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
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
    username = "YOUR_USERBANE";
    homeDirectory = "/home/YOUR_USERNAME";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
      btop
      neovim
      uv
      vscode
      code-cursor
      gimp
      lua
      go
      qemu
      rofi-power-menu
      rustc
      quickemu
      discord
      libreoffice
      arandr
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # ==== non nix dotfiles ====
  # dunst
  xdg.configFile."dunst/dunstrc".source = ./resources/dunstrc;
  # neovim
  xdg.configFile."nvim".source = ./nvim;
  # ====

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
