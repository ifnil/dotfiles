{ pkgs, ... }:
{
  imports = [
    ../default.nix
  ];

  home = {
    username = "june";
    homeDirectory = "/home/june";

  };

  services.ssh-agent.enable = true;
}
