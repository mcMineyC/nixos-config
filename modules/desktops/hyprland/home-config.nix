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
        "$lock_cmd" = "pidof hyprlock || hyprlock";
        "$suspend_cmd" = "systemctl suspend || loginctl suspend";

        general = {
            lock_cmd = "$lock_cmd";
            before_sleep_cmd = "loginctl lock-session";
        };
        listener = [
          {
            timeout = 300; # 5mins
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600; # 10mins
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
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
        "$text_color" = "rgba(FFDAD6FF)";
        "$entry_background_color" = "rgba(41000311)";
        "$entry_border_color" = "rgba(896E6C55)";
        "$entry_color" = "rgba(FFDAD6FF)";
        "$font_family" = "Rubik Light";
        "$font_family_clock" = "Rubik Light";
        "$font_material_symbols" = "Material Symbols Rounded";

        background {
            color = "rgba(181818FF)";
            # path = {{ SWWW_WALL }}
            
            # path = screenshot
            # blur_size = 15
            # blur_passes = 4
        }
        input-field {
            monitor = "";
            size = "250, 50";
            outline_thickness = 2;
            dots_size = 0.1;
            dots_spacing = 0.3;
            outer_color = "$entry_border_color";
            inner_color = "$entry_background_color";
            font_color = "$entry_color";
            fade_on_empty = true;

            position = "0, 20";
            halign = "center";
            valign = "center";
        }

        label { # Caps Lock Warning
            monitor = "";
            text = "cmd[update:250] \${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/check-capslock.sh";
            color = "$text_color";
            font_size = 13;
            font_family = "$font_family";
            position = "0, -25";
            halign = "center";
            valign = "center";
        }


        label { # Clock
            monitor = "";
            text = "$TIME";
            color = "$text_color";
            font_size = 65;
            font_family = "$font_family_clock";

            position = "0, 300";
            halign = "center";
            valign = "center";
        }
        label { # Date
            monitor = "";
            text = ''cmd[update:5000] date +"%A, %B %d"'';
            color = "$text_color";
            font_size = 17;
            font_family = "$font_family";

            position = "0, 240";
            halign = "center";
            valign = "center";
        }

        label { # User
            monitor = "";
            text = "    $USER";
            color = "$text_color";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            font_size = 20;
            font_family = "$font_family";
            position = "0, 50";
            halign = "center";
            valign = "bottom";
        }

        label { # Status
            monitor = "";
            text = "cmd[update:5000] \${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/status.sh";
            color = "$text_color";
            font_size = 14;
            font_family = "$font_family";

            position = "30, -30";
            halign = "left";
            valign = "top";
        }
      };
    };
  };
}
