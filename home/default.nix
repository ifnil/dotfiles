{ pkgs, ... }:
let gtk_theme = "Arc-Dark";
in {
  imports = [
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
    ./programs/waybar.nix

    ./wm
  ];

  home = {
    username = "june";
    homeDirectory = "/home/june";

    packages = with pkgs; [
      cowsay
      nemo
      git

      proggyfonts
      nerd-fonts.gohufont
      nerd-fonts.noto
      nerd-fonts.hurmit
      nerd-fonts.terminess-ttf
      nerd-fonts.symbols-only

      hyprshade
      hyprshot
    ];

    stateVersion = "25.05";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.arc-theme;
      name = gtk_theme;
    };

    font = {
      package = pkgs.nerd-fonts.gohufont;
      name = "GohuFont uni 14 Nerd Font Regular";
    };
  };

  programs.home-manager.enable = true;
  services.ssh-agent.enable = true;
}
