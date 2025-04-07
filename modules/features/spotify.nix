{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      adblock
      addToQueueTop
    ]; 
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
    theme = spicePkgs.themes.ziro;
  };
}
