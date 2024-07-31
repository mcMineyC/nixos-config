{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home.username = "jedi";
  home.homeDirectory = "/home/jedi";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.packages = [
    pkgs.hello

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    (pkgs.writeShellScriptBin "sys-rebuild" ''
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
  };

  programs.foot.settings = {
    main = {
      term = "xterm-256color";

      font = "JetBrainsMono Nerd Font:size=11";
      dpi-aware = "no";
      pad = "0x0";
      bold-text-in-bright = "no";
    };

    scrollback.lines = 1000;

    cursor = {
      style = "beam";
      blink = "no";
      beam-thickness = 1.5;
    };

    key-bindings = {
      scrollback-up-page = "Page_Up";
      scrollback-down-page = "Page_Down";
      clipboard-copy = "Control+Shift+C";
      clipboard-paste = "Control+Shift+V";
      search-start = "Control+Shift+F";
    };

    search-bindings = {
      cancel = "Escape";
      find-prev = "G";
      find-next = "Shift+G";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        "$mod, T, exec, foot"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
