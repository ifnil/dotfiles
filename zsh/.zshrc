# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# VARIABLES
ZSH_THEME="powerlevel10k/powerlevel10k"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

CARGO_PATH="$HOME/.cargo/bin"
GO_BIN_PATH="$HOME/go/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"
BUN_BIN_PATH="$HOME/.bun/bin"
NIX_BIN_PATH="$HOME/.nix-profile/bin"


USER_PATH="$NIX_BIN_PATH:$CARGO_PATH:$GO_BIN_PATH:$BUN_BIN_PATH:$LOCAL_BIN_PATH"

# EXPORTS
export PATH="$USER_PATH:$PATH"
export ZSH="$HOME/.config/oh-my-zsh"
export ANDROID_HOME="$HOME/code/android/sdk"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export QT_QPA_PLATFORM=xcb
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"

# PLUGINS
plugins=(
  git fzf docker docker-compose 
  eza colorize kitty ssh-agent urltools z
  zsh-autosuggestions zsh-syntax-highlighting
  zsh-completions fzf-zsh-completions
)

# ALIASES
alias ac="arduino-cli --config-file /home/june/.config/arduino/arduino-cli.yaml"
alias setwall="swww img "

# ZSH stuff :D
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.config/oh-my-zsh/custom/p10k.zsh ]] \
  || source ~/.config/oh-my-zsh/custom/p10k.zsh
