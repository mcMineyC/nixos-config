{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config.url = "github:mcMineyC/nvim-config";
    quickshell-config.url = "github:mcMineyC/quickshell-config";

    nix-colors.url = "github:misterio77/nix-colors";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
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
