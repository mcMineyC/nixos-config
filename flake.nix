{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvim-config.url = "github:mcMineyC/nvim-config";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    wallpaper = {
      url = "file+https://forkleserver.mooo.com/blogAssets/wallpapers/macos/monterey/5pm.jpg";
      hash = "aaaaaaa";
    };
  };

  outputs = { self, nixpkgs, zen-browser, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ./hosts/default/configuration.nix
        ];
      };
    };
  };
}
