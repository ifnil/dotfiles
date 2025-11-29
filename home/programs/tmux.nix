{ pkgs, ... }:
let
  grimoire = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "grimoire";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "navahas";
      repo = "tmux-grimoire";
      rev = "94b3f0087289ec5cbeb9cc225ab665661d55123c";
      hash = "sha256-oLtOO0vclwwVLYnWCY0nG+QGAdYik6L04eR606IHnW0=";
    };
  };
in
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
      ]
      ++ [
        {
          plugin = grimoire;
          extraConfig = ''
            set -g @grimoire-key "f"              # Summon the main shpell, or banish any active one
            set -g @ephemeral-grimoire-key "F"    # Summon an ephemeral shpell
            set -g @grimoire-kill-key "C"         # Banish the current shpell and erase its tmux window
          '';
        }
      ];

    keyMode = "vi";
    terminal = "xterm-kitty";

    extraConfig = ''
      set -g mouse            on 
      set -g default-shell    /Users/jlattanzi/.nix-profile/bin/zsh
      set -g default-command  /Users/jlattanzi/.nix-profile/bin/zsh
      set -g renumber-windows on
    '';
  };
}
