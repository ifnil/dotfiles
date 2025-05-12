# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# VARIABLES
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

CARGO_PATH="$HOME/.cargo/bin"
GO_BIN_PATH="$HOME/go/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"

USER_PATH="$CARGO_PATH:$GO_BIN_PATH:$LOCAL_BIN_PATH"

# EXPORTS
export PATH="$USER_PATH:$PATH"
export ZSH="$HOME/.config/oh-my-zsh"

# PLUGINS
plugins=(
  git fzf docker docker-compose 
  eza colorize kitty ssh-agent urltools z
  zsh-autosuggestions zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.config/oh-my-zsh/custom/p10k.zsh ]] \
  || source ~/.config/oh-my-zsh/custom/p10k.zsh
