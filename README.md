## Install:
copy content of ./nixos to /etc/nixos then rebuild using
``bash
  sudo nixos-rebuild switch --flake /etc/nixos#YOUR_USERNAME
``



## Description
nixos base configuration featuring :
  - Theming with stylix
  - i3 window manager
  - Basic scripting to simplify nixos's rebuild process
  - Declarative VSCode, Vim and Neovim configuration using NixVim

Based on https://github.com/Misterio77/nix-starter-configs
