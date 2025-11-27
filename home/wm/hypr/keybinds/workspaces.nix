{ lib, ... }:

let
  mod = "$mod";

  # Generate workspace numbers 1-10 (where 0 represents workspace 10)
  workspaceNumbers = lib.lists.range 1 10;

  # Helper function to map workspace number to key
  # Workspace 10 is accessed via key "0"
  numToKey = n: if n == 10 then "0" else toString n;

  # Functional helper to generate workspace bindings
  mkWorkspaceBinds =
    action: map (n: "${mod}, ${numToKey n}, ${action}, ${toString n}") workspaceNumbers;

  # Functional helper to generate move-to-workspace bindings
  mkMoveToWorkspaceBinds =
    action: map (n: "${mod} SHIFT, ${numToKey n}, ${action}, ${toString n}") workspaceNumbers;

in
{
  wayland.windowManager.hyprland.settings = {
    bind =
      # Switch to workspace N
      (mkWorkspaceBinds "workspace")
      ++

        # Move active window to workspace N (silently, without switching)
        (mkMoveToWorkspaceBinds "movetoworkspacesilent");
  };
}
