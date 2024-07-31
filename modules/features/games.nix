{config, pkgs, ...}: {
  users.users.jedi.packages = with pkgs; [
    prismlauncher
    zulu
  ];
}
