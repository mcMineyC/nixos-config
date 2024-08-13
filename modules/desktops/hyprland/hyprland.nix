{ config, pkgs, inputs, ... }:

{
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };
  environment.systemPackages = with pkgs; [
    ags
    swww
  ];
  xdg.portal.enable = true;

  programs.hyprland.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}