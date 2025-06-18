{ config, pkgs, inputs, ... }:

let
  vars = import ./vars.nix;
in

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    (import ../../modules/desktops/hyprland/home-config.nix {wallpaper = vars.wallpaper;})
    (import ../../modules/desktops/gnome/home-config.nix {wallpaper = vars.wallpaper;})
    ../../modules/features/zen.nix
    ../../modules/features/spotify.nix
    ../../modules/features/alacritty.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  home.username = vars.uname;
  home.homeDirectory = "/home/${vars.uname}";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono

    (writeShellScriptBin "sys-rebuild" ''
      #!/bin/bash
      if [ "$(pwd)" != "/home/jedi/Documents/nixos-config" ]; then
        cd /home/jedi/Documents/nixos-config
        echo "CDed to config dir"
      fi
      currentGen=$(nix-env --list-generations | grep current | awk '{print $1}')
      echo "Now on generation $((currentGen + 1))"
      echo "Committing changes"
      git add .
      git commit -m "Update on $(date), gen $((currentGen + 1))"
      git push
      echo "Done"
      sudo NIXPKGS_ALLOW_UNFREE="1" nixos-rebuild switch --impure --flake /home/jedi/Documents/nixos-config#default
    '')

    spotube
  ];

  home.file = {
    ".config/nvim" = {
      source = inputs.nvim-config;
      recursive = true;
    };
    ".config/quickshell" = {
      source = inputs.quickshell-config;
      recursive = true;
    };
    ".config/nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';

    ".config/hypr/hyprlock/check-capslock.sh".text = ''
      #!/bin/env bash

      MAIN_KB_CAPS=$(hyprctl devices | grep -B 6 "main: yes" | grep "capsLock" | head -1 | awk '{print $2}')

      if [ "$MAIN_KB_CAPS" = "yes" ]; then
          echo "Caps Lock active"
      else
          echo ""
      fi
    '';
    ".config/hypr/hyprlock/status.sh".text = ''
      #!/usr/bin/env bash

      ############ Variables ############
      enable_battery=false
      battery_charging=false

      ####### Check availability ########
      for battery in /sys/class/power_supply/*BAT*; do
        if [[ -f "$battery/uevent" ]]; then
          enable_battery=true
          if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
            battery_charging=true
          fi
          break
        fi
      done

      ############# Output #############
      if [[ $enable_battery == true ]]; then
        if [[ $battery_charging == true ]]; then
          echo -n "(+) "
        fi
        echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)"%
        if [[ $battery_charging == false ]]; then
          echo -n " remaining"
        fi
      fi

      echo
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userEmail = "jedi.master@falconhosting.net";
    userName = "mcMineyC";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
