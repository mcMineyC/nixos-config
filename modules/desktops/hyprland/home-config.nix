{wallpaper, ...}: { config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      "$mod" = "SUPER";
      preload = "${wallpaper}";
      wallpaper = ",${wallpaper}";
      exec-once = [
        # "swww init"
        # "swww img ${wallpaper} --transition-type fade --transition-duration 1"
        # "makoctl set-mode default"
        # "dunst"
        # "blueman-applet"
        # "nm-applet"
        # "pasystray"
        # "wl-paste -t text/plain -t text/html -t image/png --watch cliphist add"
        # "gnome-keyring-daemon --start --components=secrets"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "makoctl set-mode default"
      ];
      bind =
        [
          "$mod, B, exec, zen"
          "$mod, F, exec, nautilus"
          "$mod, T, exec, alacritty"
          # "$mod, C, exec, google-chrome-stable"
          "$mod SHIFT, C, exec, code"
          "$mod Q, killactive"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod ALT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      monitors = {
        eDP-1 = {
          path = wallpaper;
          mode = "fill";
          interval = 300;
          transition = "fade";
          transitionDuration = 1;
        };
      };
    };
  };
}
