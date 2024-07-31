{ config, pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      flutter
      dart
    ];
}
