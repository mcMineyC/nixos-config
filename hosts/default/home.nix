{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/desktops/gnome/home-config.nix
    ../../modules/features/alacritty.nix
  ];

  confPath = "/home/jedi/Documents/nixos-config";
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.username = "jedi";
  home.homeDirectory = "/home/jedi";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    (writeShellScriptBin "sys-rebuild" ''
      #!/bin/bash
      if [ "$(pwd)" != "${confPath}" ]; then
        cd ${confPath}
        echo "CDed to config dir"
      fi
      currentGen=$(nix-env --list-generations | grep current | awk '{print $1}')
      echo "Now on generation $((currentGen + 1))"
      echo "Committing changes"
      git add .
      git commit -m "Update on $(date), gen $((currentGen + 1))"
      git push
      echo "Done"
      sudo nixos-rebuild switch --flake ${confPath}#default
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

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        "$mod, T, exec, alacritty"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod ALT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
