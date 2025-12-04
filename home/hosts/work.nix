{ pkgs, ... }:
{
  imports = [
    ../default.nix
  ];

  home = {
    username = "jlattanzi";
    homeDirectory = "/Users/jlattanzi";
  };

  gtk.enable = false; # GTK not typically needed on macOS
}
