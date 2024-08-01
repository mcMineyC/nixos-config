{ config, pkgs, inputs, ... }:

{
  imports = [
    ./flutter.nix
  ];
  users.users.jedi = {
    packages = with pkgs; [
      #VS Code
      vscode

      # Zed
      zed-editor

      # Neovim
      inputs.nvim-config
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