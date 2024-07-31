{ config, pkgs, inputs, ... }:

{
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, T, exec, foot"
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
              "$mod ALT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    }
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  environment.systemPackages = [
    pkgs.waybar
    (pkg.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      })
    )
    pkgs.ags
    swww
    foot
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}