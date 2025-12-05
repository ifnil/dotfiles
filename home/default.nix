{ pkgs, lib, ... }:
{
  imports = [
    ./programs
    ./wm
  ];

  home = {
    sessionPath = [
      "~/.cargo/bin"
      "~/go/bin"
      "~/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      cowsay
      git
      zig
      signal-desktop-bin
      claude-code
      jq
      gum

      # Hyprland dependencies
      waybar
      swww
      dunst
      hyprpolkitagent

      proggyfonts
      nerd-fonts.gohufont
      nerd-fonts.noto
      nerd-fonts.hurmit
      nerd-fonts.terminess-ttf
      nerd-fonts.symbols-only
    ];

    stateVersion = "25.05";
  };

  gtk = lib.mkDefault {
    enable = true;
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };

    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };

    font = {
      package = pkgs.nerd-fonts.gohufont;
      name = "GohuFont uni 14 Nerd Font Regular";
    };
  };

  programs.home-manager.enable = true;
}
