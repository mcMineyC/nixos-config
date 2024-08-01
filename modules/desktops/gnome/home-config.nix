{ config, pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            package = (pkgs.orchis-theme.override ({ 
                        tweaks = ["macos" "black"];
                    }));
            name = "Orchis-Dark";
        };
    };
}