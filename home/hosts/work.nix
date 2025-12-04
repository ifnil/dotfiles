{ pkgs, ... }:
{
  imports = [
    ../default.nix
  ];

  home = {
    username = "jlattanzi";
    homeDirectory = "/Users/jlattanzi";
  };

  # macOS-specific overrides
  gtk.enable = false; # GTK not typically needed on macOS
}
