{ pkgs, ... }:
{
  imports = [
    ./keybinds
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];

    settings = {
      "$mod" = "SUPER";

      monitor = ", 3840x2160@120, 0x0, 2";

      plugin = {
        hy3 = {
          autotile = {
            enable = true;
          };
        };
      };

      general = {
        layout = "hy3";
        border_size = 3;
        gaps_in = 5;
        resize_on_border = true;
      };

      master = {
        allow_small_split = true;
        slave_count_for_center_master = 0;
      };

      dwindle = {
        preserve_split = true;
      };

      input = {
        kb_options = "caps:escape_shifted_capslock";
      };

      decoration = {
        rounding = 0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = true;
          new_optimizations = true;
        };
      };
    };
  };
}
