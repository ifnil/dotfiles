{ pkgs, ... }: {
  imports = [ ./keybinds ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    plugins = [ pkgs.hyprlandPlugins.hy3 ];

    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "swww-daemon"
        "dunst"
        "waybar"
        "systemctl --user start hyprpolkitagent"
        "hyprpm reload -n"
      ];

      monitor = [ "eDP-1, 1920x1200@60, 0x0, 1" ", 3840x2160@120, 0x0, 2" ];

      general = {
        layout = "dwindle";
        border_size = 5;
        gaps_in = 5;
        resize_on_border = true;

        "col.active_border" = "rgba(68a88fff)";
      };

      master = {
        allow_small_split = true;
        slave_count_for_center_master = 0;
      };

      dwindle = { preserve_split = true; };

      input = { kb_options = "caps:escape_shifted_capslock"; };

      decoration = {
        rounding = 10;
        rounding_power = 4;
        border_part_of_window = false;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = true;
          new_optimizations = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        font_family = "GohuFont uni 14 Nerd Font";
      };
    };
  };
}
