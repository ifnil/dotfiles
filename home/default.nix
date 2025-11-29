{ pkgs, ... }: {
  imports = [
    ./programs/waybar.nix
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
  ];

  home = {
    username = "june";
    homeDirectory = "/home/june";
    sessionPath = [ "~/.cargo/bin" "~/go/bin" "~/.local/bin" ];
    sessionVariables = { EDITOR = "nvim"; };

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
    ];

    stateVersion = "25.05";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };

    font = {
      package = pkgs.nerd-fonts.gohufont;
      name = "GohuFont uni 14 Nerd Font Regular";
    };
  };

  programs.home-manager.enable = true;
  services.ssh-agent.enable = true;
}
