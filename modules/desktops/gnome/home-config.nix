{ config, pkgs, ... }:


{
  imports = [
    ./dconf-settings.nix
  ];
  gtk = {
    enable = true;
      theme = {
        package = (pkgs.orchis-theme.override ({ 
          tweaks = ["macos" "black"];
        }));
        name = "Orchis-Dark";
      };
  };
  # workspace keybinds
  # ++ (
  #   # workspaces
  #   # binds super + {1..10} to [move to] workspace {1..10}
  #   builtins.concatLists (builtins.genList (
  #     x: let
  #       ws = let
  #         c = (x + 1) / 10;
  #       in
  #         builtins.toString (x + 1 - (c * 10));
  #     in [
  #       switch-to-workspace-${ws} = [ "<Super>${ws}" ];
  #       # "$mod, ${ws}, workspace, ${toString (x + 1)}"
  #       # "$mod ALT, ${ws}, movetoworkspace, ${toString (x + 1)}"
  #     ]
  #   )
  #   10)
  # );
}
