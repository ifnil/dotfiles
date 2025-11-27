{ lib, ... }:

let
  mod = "$mod";

  # Functional helper to create directional bindings
  # Creates bindings for both arrow keys and vim-style hjkl
  mkDirectionalBinds =
    {
      modifiers,
      action,
      command,
    }:
    let
      directions = {
        arrows = {
          Left = {
            key = "Left";
            dir = "l";
            comment = "left";
          };
          Down = {
            key = "Down";
            dir = "d";
            comment = "down";
          };
          Up = {
            key = "Up";
            dir = "u";
            comment = "up";
          };
          Right = {
            key = "Right";
            dir = "r";
            comment = "right";
          };
        };
        vim = {
          H = {
            key = "H";
            dir = "l";
            comment = "left";
          };
          J = {
            key = "J";
            dir = "d";
            comment = "down";
          };
          K = {
            key = "K";
            dir = "u";
            comment = "up";
          };
          L = {
            key = "L";
            dir = "r";
            comment = "right";
          };
        };
      };

      mkBind =
        {
          key,
          dir,
          comment,
        }:
        "${modifiers}, ${key}, ${action}, ${dir}";
    in
    (map mkBind (lib.attrValues directions.arrows)) ++ (map mkBind (lib.attrValues directions.vim));

  # Helper for monitor workspace movement
  mkMonitorBinds =
    { modifiers }:
    let
      directions = [
        {
          key = "Left";
          dir = "-1";
        }
        {
          key = "Down";
          dir = "-1";
        }
        {
          key = "Right";
          dir = "+1";
        }
        {
          key = "Up";
          dir = "+1";
        }
      ];

      mkBind = { key, dir }: "${modifiers}, ${key}, movecurrentworkspacetomonitor, ${dir}";
    in
    map mkBind directions;

in
{
  wayland.windowManager.hyprland.settings = {
    bind =
      # Window focus navigation (hy3 plugin)
      (mkDirectionalBinds {
        modifiers = mod;
        action = "hy3:movefocus";
        command = "";
      })
      ++

        # Window movement
        (mkDirectionalBinds {
          modifiers = "${mod} SHIFT";
          action = "hy3:movewindow";
          command = "";
        })
      ++

        # Move workspace to another monitor
        (mkMonitorBinds {
          modifiers = "${mod} ALT";
        })
      ++

        # Window management actions
        [
          "${mod}, W, togglegroup"
          "${mod}, E, togglesplit"
          "${mod}, F, fullscreen"
          "${mod} SHIFT, space, togglefloating"
        ];
  };
}
