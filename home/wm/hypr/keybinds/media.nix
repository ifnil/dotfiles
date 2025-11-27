{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Audio control with wpctl (primary)
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

    # Audio control with amixer (fallback)
    bindle = [
      ", XF86AudioRaiseVolume, exec, amixer sset Master 2%+"
      ", XF86AudioLowerVolume, exec, amixer sset Master 2%-"
    ];

    bind = [
      # Media player controls
      ", XF86AudioMute, exec, amixer sset Master toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # Keyboard brightness
      ", XF86KbdBrightnessUp, exec, brightnessctl --device='smc::kbd_backlight' set +5%"
      ", XF86KbdBrightnessDown, exec, brightnessctl --device='smc::kbd_backlight' set 5%-"

      # Workspace navigation with function keys
      "$mod, XF86AudioRaiseVolume, workspace, +1"
      "$mod, XF86AudioLowerVolume, workspace, -1"
    ];

    # Monitor brightness controls
    binde = [
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

    # Layout message swapping with function keys
    bindp = [
      "$mod SHIFT, XF86AudioRaiseVolume, layoutmsg, swapnext"
      "$mod SHIFT, XF86AudioLowerVolume, layoutmsg, swapnext prev"
    ];
  };
}
