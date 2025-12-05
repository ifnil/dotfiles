{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;

    extraConfig = {
      modes = "combi,drun,run,emoji,ssh";
      combi-modes = "drun,run";
      display-combi = "All";
      display-drun = "Applications";
      display-run = "Run";
      display-emoji = "Emoji";
      display-ssh = "SSH";
      font = "GohuFont 14 Nerd Font 12";
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          background-color = mkLiteral "#000000";
          foreground-color = mkLiteral "rgba ( 250, 251, 252, 100 % )";
          border-color = mkLiteral "#FFFFFF";
        };

        "window" = {
          width = mkLiteral "512px";
          padding = mkLiteral "10px";
        };

        "listview" = {
          lines = 10;
          padding = mkLiteral "5px";
        };

        "element" = {
          padding = mkLiteral "5px";
        };

        "element selected" = {
          background-color = mkLiteral "#333333";
        };

        "inputbar" = {
          children = mkLiteral "[prompt,entry]";
        };

        "textbox-prompt-colon" = {
          expand = false;
          str = ":";
          margin = mkLiteral "0px 0.3em 0em 0em";
          text-color = mkLiteral "@foreground-color";
        };
      };
  };
}
