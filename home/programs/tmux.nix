{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    plugins =
      with pkgs.tmuxPlugins;
      [
        sensible
        yank
        tmux-fzf
        tmux-which-key
        vim-tmux-navigator
        resurrect
        continuum
        {
          plugin = minimal-tmux-status;
          extraConfig = ''
            set -g @minimal-tmux-bg            "#6ba6ad"
            set -g @minimal-tmux-justify       "left"
            set -g @minimal-tmux-indicator-str " work "
          '';
        }
      ];

    keyMode = "vi";
    terminal = "xterm-kitty";

    extraConfig = ''
      set -g mouse            on 
      set -g default-shell    ~/.nix-profile/bin/zsh
      set -g default-command  ~/.nix-profile/bin/zsh
      set -g renumber-windows on
    '';
  };
}
