{ config, pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            package = pkgs.orchis-theme;
            name = "Orchis-Dark"
        };
    };
}