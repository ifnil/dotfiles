{
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;

      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      historySubstringSearch.enable = true;

      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "git"
      ];

      shellAliases = {
        lsl = "ls -al";
        cj = "z";
        ssh = "kitten ssh";
        setwall = "swww img";
        jq = "jq -C";
      };
    };

    zoxide.enable = true;
    zoxide.enableZshIntegration = true;

    starship.enable = true;
    starship.enableZshIntegration = true;
  };
}
