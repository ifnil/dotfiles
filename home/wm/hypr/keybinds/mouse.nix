{ lib, ... }:

let
  mod = "$mod";

  # Mouse button definitions for clarity
  mouse = {
    LMB = "mouse:272"; # Left mouse button
    RMB = "mouse:273"; # Right mouse button
  };

  # Functional helper to create mouse bindings
  mkMouseBinds =
    bindings:
    map (
      {
        modifiers,
        button,
        action,
        comment,
      }:
      "${modifiers}, ${button}, ${action}"
    ) bindings;

in
{
  wayland.windowManager.hyprland.settings = {
    bindm = mkMouseBinds [
      # Basic mouse operations
      {
        modifiers = mod;
        button = mouse.LMB;
        action = "movewindow";
        comment = "Drag window with Mod + LMB";
      }
      {
        modifiers = mod;
        button = mouse.RMB;
        action = "resizewindow";
        comment = "Resize window with Mod + RMB";
      }

      # Alternative with SHIFT modifier
      {
        modifiers = "${mod} SHIFT";
        button = mouse.LMB;
        action = "movewindow";
        comment = "Drag window with Mod + Shift + LMB";
      }
      {
        modifiers = "${mod} SHIFT";
        button = mouse.RMB;
        action = "resizewindow";
        comment = "Resize window with Mod + Shift + RMB";
      }
    ];
  };
}
