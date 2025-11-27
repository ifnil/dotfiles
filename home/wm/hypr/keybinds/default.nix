{ ... }:

{
  imports = [
    ./core.nix # Core keybinds (terminal, kill, rofi, reload)
    ./media.nix # Media and function keys (audio, brightness)
    ./navigation.nix # Window focus and movement
    ./workspaces.nix # Workspace switching and window movement
    ./mouse.nix # Mouse bindings
    ./submaps.nix # Submaps (resize, power, screenshot)
  ];
}
