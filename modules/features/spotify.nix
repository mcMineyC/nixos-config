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
    enabledExtensions = with spicepkgs.extensions; [
      fullAppDisplay
      adblock
    ]; 
    theme = spicePkgs.themes.ziro;
  };
}
