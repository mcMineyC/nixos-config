{ config, pkgs, inputs, ... }:

{
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
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