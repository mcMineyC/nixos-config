{ config, pkgs, inputs, ... }:

let
  vars = import ./vars.nix;
in

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/desktops/hyprland/home-config.nix
    ../../modules/desktops/gnome/home-config.nix
    ../../modules/features/alacritty.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;
  home.username = vars.uname;
  home.homeDirectory = "/home/${vars.uname}";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    nerdfonts.jetbrains-mono

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
      sudo nixos-rebuild switch --flake /home/jedi/Documents/nixos-config#default
    '')

    spotube
  ];

  home.file = {
    ".config/nvim" = {
      source = inputs.nvim-config;
      recursive = true;
    };
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
