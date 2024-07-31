{ config, pkgs, ... }:

{
  imports = [
    ./flutter.nix
  ];
  users.users.jedi = {
    packages = with pkgs; [
      #VS Code
      vscode

      # Neovim
      neovim
      tree-sitter
      nodejs_22
      nodePackages.npm
      python3
      python312Packages.pip
      gccgo14
      wl-clipboard-x11
      wl-clipboard
      unzip
    ];
  };
}