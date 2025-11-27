{ lib, ... }:

let
  mod = "$mod";

  # Functional helper to create submap bindings
  # A submap is a modal keybinding system (like vim modes)
  mkSubmap =
    {
      name,
      triggers,
      bindings,
      exitKeys ? [
        "escape"
        "enter"
      ],
    }:
    let
      # Create trigger bindings to enter the submap
      triggerBinds = map (
        {
          key,
          comment ? "",
        }:
        "${key}, submap, ${name}" + lib.optionalString (comment != "") "   # ${comment}"
      ) triggers;

      # Create bindings within the submap
      submapBinds = map (
        {
          key,
          type ? "bind",
          action,
          command,
          comment ? "",
          resetAfter ? false,
        }:
        let
          binding = "${type} = , ${key}, ${action}, ${command}";
          withComment = binding + lib.optionalString (comment != "") "   # ${comment}";
          # If resetAfter is true, also add a reset binding after the action
          resetBinding = lib.optional resetAfter "${type} = , ${key}, exec, reset";
        in
        [ withComment ] ++ resetBinding
      ) bindings;

      # Create exit bindings
      exitBinds = map (key: "bind = , ${key}, submap, reset") exitKeys;

      # Flatten all bindings and wrap in submap declaration
      allBinds = lib.flatten submapBinds ++ exitBinds;
    in
    {
      triggers = triggerBinds;
      submap = [ "submap = ${name}" ] ++ allBinds ++ [ "submap = reset" ];
    };

  # Define resize submap
  resizeSubmap = mkSubmap {
    name = "resize";
    triggers = [
      {
        key = "${mod}, R";
        comment = "Enter resize mode";
      }
    ];
    bindings = [
      {
        key = "h";
        type = "binde";
        action = "resizeactive";
        command = "40 0";
        comment = "Resize right";
      }
      {
        key = "l";
        type = "binde";
        action = "resizeactive";
        command = "-40 0";
        comment = "Resize left";
      }
      {
        key = "k";
        type = "binde";
        action = "resizeactive";
        command = "0 -40";
        comment = "Resize up";
      }
      {
        key = "j";
        type = "binde";
        action = "resizeactive";
        command = "0 40";
        comment = "Resize down";
      }
    ];
  };

  # Define power/machine control submap
  powerSubmap = mkSubmap {
    name = "machine_ctl";
    triggers = [
      {
        key = "${mod} SHIFT, E";
        comment = "Enter power menu";
      }
    ];
    bindings = [
      {
        key = "e";
        type = "binde";
        action = "exec";
        command = "hyprctl dispatch exit";
        comment = "Exit Hyprland";
        resetAfter = true;
      }
      {
        key = "l";
        type = "binde";
        action = "exec";
        command = "hyprlock";
        comment = "Lock screen";
        resetAfter = true;
      }
      {
        key = "u";
        type = "binde";
        action = "exec";
        command = "systemctl suspend";
        comment = "Suspend";
        resetAfter = true;
      }
      {
        key = "s";
        type = "binde";
        action = "exec";
        command = "systemctl poweroff";
        comment = "Shutdown";
        resetAfter = true;
      }
      {
        key = "r";
        type = "binde";
        action = "exec";
        command = "systemctl reboot";
        comment = "Reboot";
        resetAfter = true;
      }
    ];
  };

  # Define screenshot submap
  screenshotSubmap = mkSubmap {
    name = "screenshot";
    triggers = [
      {
        key = "ALT&Shift_L, 4";
        comment = "Enter screenshot mode";
      }
    ];
    bindings = [
      {
        key = "p";
        type = "binde";
        action = "exec";
        command = "hyprshot -m region";
        comment = "Screenshot region";
        resetAfter = true;
      }
    ];
  };

  # Collect all submaps
  allSubmaps = [
    resizeSubmap
    powerSubmap
    screenshotSubmap
  ];

  # Extract all trigger bindings
  allTriggers = lib.flatten (map (s: s.triggers) allSubmaps);

  # Extract and format all submap definitions
  allSubmapDefinitions = lib.flatten (map (s: s.submap) allSubmaps);

in
{
  wayland.windowManager.hyprland = {
    settings = {
      # Bindings to trigger submaps
      bind = allTriggers;
    };

    # Raw configuration for submap definitions
    # Submaps need special formatting that's not directly supported by settings
    extraConfig = ''
      # === Submaps ===
      ${lib.concatStringsSep "\n" allSubmapDefinitions}
    '';
  };
}
