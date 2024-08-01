{ pkgs, config, ... }:

{
  newOrchis = pkgs.orchis-theme.override { 
    tweaks = ["macos" "dark"];
  };
  environment.systemPackages = [
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.media-controls
    pkgs.gnome-tweaks
    pkgs.gtk-engine-murrine
    newOrchis
  ];
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.flatpak = {
    enable = true;
    packages = [
      "org.gnome.Extensions"
    ];
  };

}