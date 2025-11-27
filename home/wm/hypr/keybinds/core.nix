{ lib, ... }:

let
  mod = "$mod";
in
{
  wayland.windowManager.hyprland.settings = {
    # Variable definitions
    "$mod" = "SUPER";
    "$term" = "kitty";
    "$rofi" = "rofi -show combi -combi-modi \"drun,run\" -terminal kitty -show-icons -lines 10";

    # Core application and system keybinds
    bind = [
      "${mod}, Return, exec, $term"
      "${mod} SHIFT, Q, killactive"
      "${mod}, D, exec, $rofi"
      "${mod} SHIFT, C, exec, hyprctl reload"
    ];
  };
}
