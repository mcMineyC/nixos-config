{ pkgs, config, ... }:

{
  
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.media-controls
    gnome-tweaks
    gtk-engine-murrine
    pkgs.orchis-theme.override { 
      tweaks = ["macos" "dark"];
    }
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