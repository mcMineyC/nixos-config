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
    ];
  };
}