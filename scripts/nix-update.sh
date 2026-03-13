#!/bin/sh

NO_FORMAT="\033[0m"
C_RED1="\033[38;5;196m"
C_SPRINGGREEN3="\033[38;5;35m"

sudo git -C /etc/nixos status
sleep 2

sudo git -C /etc/nixos add /etc/nixos

if sudo nixos-rebuild switch --flake /etc/nixos#YOUR_USERNAME; then
    echo -e "${C_SPRINGGREEN3}=====   NIX REBUILD OK   =====${NO_FORMAT}"
    sudo git -C /etc/nixos commit -m "chore: nix rebuild script auto-generated message"
    sudo git -C /etc/nixos push
    # read -p "Press Enter to reboot (Ctrl+c to stop reboot)" </dev/tty
    # reboot
else
    echo -e "${C_RED1}=====   NIX REBUILD ERROR   =====${NO_FORMAT}"
fi

