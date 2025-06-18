{wallpaper, ...}: { config, pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      "$mod" = "SUPER";
      # preload = "${wallpaper}";
      # wallpaper = ",${wallpaper}";
      general = {
        border_size = 0;
        no_border_on_floating = true;
      };
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
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, B, exec, zen"
          "$mod, F, exec, nautilus"
          "$mod, T, exec, alacritty"
          # "$mod, C, exec, google-chrome-stable"
          "$mod SHIFT, C, exec, code"
          "$mod, Q, killactive"
          "$mod ALT, D, fullscreen, 0"
          "$mod ALT, F, fullscreen, 1"
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
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = "${wallpaper}";
        wallpaper = "eDP-1,${wallpaper}";
      };
    };
    hypridle = {
      enable = true;
      settings = {
        "$lock_cmd" = pidof hyprlock || hyprlock;
        "$suspend_cmd" = systemctl suspend || loginctl suspend;

        general = {
            lock_cmd = "$lock_cmd";
            before_sleep_cmd = loginctl lock-session;
        };
        listener = [
          {
            timeout = 300; # 5mins
            on-timeout = loginctl lock-session;
          }
          {
            timeout = 600; # 10mins
            on-timeout = hyprctl dispatch dpms off;
            on-resume = hyprctl dispatch dpms on;
          }
          {
            timeout = 900; # 15mins
            on-timeout = "$suspend_cmd";
          }

        ];
      };
    };
    hyprlock = {
      enable = true;
      settings = {
        
      };
    }
  }
}
