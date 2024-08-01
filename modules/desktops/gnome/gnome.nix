{ pkgs, config, ... }:

{
  config.packageOverrides = pkgs: {
    orchis-theme = pkgs.orchis-theme.override { 
      tweaks = ["macos" "dark"];
    };
  };
  config.environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.media-controls
    gnome-tweaks
    gtk-engine-murrine
    orchis-theme
  ];
  
  # Enable the X11 windowing system.
  config.services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  config.services.xserver.displayManager.gdm.enable = true;
  config.services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  config.services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  config.services.flatpak = {
    enable = true;
    packages = [
      "org.gnome.Extensions"
    ];
  };

}